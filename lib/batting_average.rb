class BattingAverage
  include Comparable

  class << self

    def calculate(appearance: nil, bat: nil, hit: nil)
      return new(-1) if appearance == 0
      return new(0) if bat == 0
      new(hit.to_f / bat.to_f)
    end

    def from_s(string)
      new(string.to_f)
    end
  end

  def initialize(value)
    @value = value
  end

  def nil?
    @value == -1
  end

  def value_with_digit(digit=3)
    "%.#{digit}f" % @value
  end

  def to_s
    return '----' if nil?
    return '1.00' if @value >= 1.0
    value_with_digit.sub(/^0/, '')
  end

  def <=>(other)
    - (self.value_with_digit <=> other.value_with_digit)
  end
end
