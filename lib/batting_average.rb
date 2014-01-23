module BattingAverage
  class << self

    def calculate(score)
      return Nil.new(score) if score[:appearance] == 0
      return Standard.new(0, score) if score[:bat] == 0
      create_by_average(score[:hit].to_f / score[:bat].to_f, score)
    end

    def from_s(string)
      create_by_average(string.to_f, nil)
    end

  private

    def create_by_average(average, score)
      if average == 1.0
        Full.new(score)
      else
        Standard.new(average, score)
      end
    end
  end

  class Base
    include Comparable

    def initialize(value, score=nil)
      @value = value
      @score = score
    end

    def appearance
      @score[:appearance]
    end

    def nil?
      false
    end

    def value_with_digit(digit=3)
      "%.#{digit}f" % @value
    end

    def <=>(other)
      - (self.value_with_digit <=> other.value_with_digit)
    end
  end

  class Nil < Base

    def initialize(score)
      super(-1, score)
    end

    def nil?
      true
    end

    def to_s
      '----'
    end
  end

  class Full < Base

    def initialize(score)
      super(1.0, score)
    end

    def to_s
      '1.00'
    end
  end

  class Standard < Base

    def to_s
      value_with_digit.sub(/^0/, '')
    end
  end
end
