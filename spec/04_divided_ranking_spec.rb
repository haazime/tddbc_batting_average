require 'spec_helper'

describe "規定打席数消化別打率ランキング" do
  subject do
    BattingAverageRanking
      .create_with_appearance_status(players, team_games)
  end

  let(:team_games) do
    {
      team_a: 30, # 93
      team_b: 31, # 96
      team_c: 28  # 87
    }
  end

  let(:a1) { Player.new("A1", :team_a) }
  let(:b1) { Player.new("B1", :team_b) }
  let(:c1) { Player.new("C1", :team_c) }
  let(:a2) { Player.new("A2", :team_a) }
  let(:b2) { Player.new("B2", :team_b) }
  let(:c2) { Player.new("C2", :team_c) }

  context "全員規定打席に達している" do
    let(:players) { [a1, b1, c1] }

    before do
      a1.batting_score = { appearance: 100, bat: 80, hit: 30 }
      b1.batting_score = { appearance: 100, bat: 80, hit: 40 }
      c1.batting_score = { appearance: 100, bat: 80, hit: 20 }
    end

    it "規定打席達成ランキング：1位B1 2位A1 3位C1" do
      expect(subject[:official].each_with_rank.to_a).to eq ([[b1, 1], [a1, 2], [c1, 3]])
    end

    it "規定打席未達ランキング：なし" do
      expect(subject[:unofficial]).to be_nil
    end
  end

  context "全員規定打席に達していない" do
    let(:players) { [a2, b2, c2] }

    before do
      a2.batting_score = { appearance: 50, bat: 40, hit: 8 }
      b2.batting_score = { appearance: 50, bat: 40, hit: 6 }
      c2.batting_score = { appearance: 50, bat: 40, hit: 10 }
    end

    it "規定打席達成ランキングなし" do
      expect(subject[:official]).to be_nil
    end

    it "規定打席未達ランキング：1位C2 2位A2 3位B2" do
      expect(subject[:unofficial].each_with_rank.to_a).to eq ([[c2, 1], [a2, 2], [b2, 3]])
    end
  end

  context '規定打席に達している/達していないが混在している' do
    let(:players) { [a1, a2, b1, b2, c1, c2] }

    before do
      a1.batting_score = { appearance: 93, bat: 50, hit: 14 }
      b1.batting_score = { appearance: 96, bat: 50, hit: 16 }
      c1.batting_score = { appearance: 87, bat: 50, hit: 17 }
      a2.batting_score = { appearance: 92, bat: 50, hit: 22 }
      b2.batting_score = { appearance: 95, bat: 50, hit: 12 }
      c2.batting_score = { appearance: 86, bat: 50, hit: 17 }
    end

    it "規定打席達成ランキング：1位C1 2位B1 3位A1" do
      expect(subject[:official].each_with_rank.to_a).to eq ([[c1, 1], [b1, 2], [a1, 3]])
    end

    it "規定打席未達ランキング：1位A2 2位C2 3位B2" do
      expect(subject[:unofficial].each_with_rank.to_a).to eq ([[a2, 1], [c2, 2], [b2, 3]])
    end
  end
end
