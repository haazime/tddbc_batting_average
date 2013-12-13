require 'spec_helper'

describe "打率ランキング" do
  subject do
    Ranking.new(players).order_by_batting_average
  end

  context "選手のリストが空" do
    let(:players) { [] }

    it { expect(subject).to be_empty }
  end

  context "playerA=10/8/3, playerB=10/8/4, playerC=10/8/2" do
    let(:players) { [a, b, c] }
    let(:a) { Player.new("A").score_batting_average(appearance: 10, bat: 8, hit: 3) }
    let(:b) { Player.new("B").score_batting_average(appearance: 10, bat: 8, hit: 4) }
    let(:c) { Player.new("C").score_batting_average(appearance: 10, bat: 8, hit: 2) }

    it { expect(subject).to eq([b,a,c]) }
  end

  context "playerA=10/0/0, playerB=0/0/0, playerC=10/8/2" do
    let(:players) { [a, b, c] }
    let(:a) { Player.new("A").score_batting_average(appearance: 10, bat: 0, hit: 0) }
    let(:b) { Player.new("B").score_batting_average(appearance: 0, bat: 0, hit: 0) }
    let(:c) { Player.new("C").score_batting_average(appearance: 10, bat: 8, hit: 2) }

    it { expect(subject).to eq([c,a,b]) }
  end
end
