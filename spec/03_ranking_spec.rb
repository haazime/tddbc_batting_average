require 'spec_helper'

describe "打率ランキング" do
  subject do
    BattingAverageRanking.create(players)
  end

  context "選手のリストが空" do
    let(:players) { [] }

    it { expect(subject).to be_nil }
  end

  let(:a) { Player.new("A") }
  let(:b) { Player.new("B") }
  let(:c) { Player.new("C") }

  context "playerA=10/8/3, playerB=10/8/4, playerC=10/8/2" do
    let(:players) { [a, b, c] }

    before do
      a.batting_score = { appearance: 10, bat: 8, hit: 3 }
      b.batting_score = { appearance: 10, bat: 8, hit: 4 }
      c.batting_score = { appearance: 10, bat: 8, hit: 2 }
    end

    it "1位B 2位A 3位C" do
      expect(subject.each_with_rank.to_a).to eq([[b, 1], [a, 2], [c, 3]])
    end
  end

  context "playerA=10/0/0, playerB=0/0/0, playerC=10/8/2" do
    let(:players) { [a, b, c] }

    before do
      a.batting_score = { appearance: 10, bat: 0, hit: 0 }
      b.batting_score = { appearance: 0, bat: 0, hit: 0 }
      c.batting_score = { appearance: 10, bat: 8, hit: 2 }
    end

    it "1位C 2位A 3位B" do
      expect(subject.each_with_rank.to_a).to eq([[c, 1], [a, 2], [b, 3]])
    end
  end
end
