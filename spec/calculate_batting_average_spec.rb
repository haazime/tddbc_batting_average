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

  context "2打席2打数1安打の場合" do
    let(:appearance) { 2 }
    let(:bat) { 2 }
    let(:hit) { 1 }

    it { expect(subject).to eq("0.500") }
  end

  context "4打席3打数1安打の場合" do
    let(:appearance) { 4 }
    let(:bat) { 3 }
    let(:hit) { 1 }

    it { expect(subject).to eq("0.333") }
  end

  context "4打席4打数1安打の場合" do
    let(:appearance) { 4 }
    let(:bat) { 4 }
    let(:hit) { 1 }

    it { expect(subject).to eq("0.250") }
  end

  context "15000打席10000打数1666安打の場合" do
    let(:appearance) { 15000 }
    let(:bat) { 10000 }
    let(:hit) { 1666 }

    it { expect(subject).to eq("0.167") }
  end

  context "15000打席10000打数1663安打の場合" do
    let(:appearance) { 15000 }
    let(:bat) { 10000 }
    let(:hit) { 1663 }

    it { expect(subject).to eq("0.166") }
  end
end
