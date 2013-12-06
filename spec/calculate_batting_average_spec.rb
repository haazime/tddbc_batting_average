require 'spec_helper'
require 'batting_average'

describe "打率の計算" do
  subject do
    BattingAverage.calculate(
      appearance: appearance,
      bat: bat,
      hit: hit
    )
  end

  let(:appearance) { nil }
  let(:bat) { nil }
  let(:hit) { nil }

  context "打席数が0の場合" do
    let(:appearance) { 0 }

    it { expect(subject).to be_nil }
  end

  context "打席数が０でなく打数が0の場合" do
    let(:appearance) { 8 }
    let(:bat) { 0 }

    it { expect(subject).to eq("0.000") }
  end

  context "1打席1打数1安打の場合" do
    let(:appearance) { 1 }
    let(:bat) { 1 }
    let(:hit) { 1 }

    it { expect(subject).to eq("1.000") }
  end

  [
    { appearance: 2, bat: 2, hit: 1, expected: "0.500" },
    { appearance: 4, bat: 3, hit: 1, expected: "0.333" },
    { appearance: 4, bat: 4, hit: 1, expected: "0.250" },
    { appearance: 15000, bat: 10000, hit: 1666, expected: "0.167" },
    { appearance: 15000, bat: 10000, hit: 1663, expected: "0.166" },
  ].each do |d|
    context "#{d[:appearance]}打席#{d[:bat]}打数#{d[:hit]}安打の場合" do
      let(:appearance) { d[:appearance] }
      let(:bat) { d[:bat] }
      let(:hit) { d[:hit] }

      it { expect(subject).to eq(d[:expected]) }
    end
  end
end
