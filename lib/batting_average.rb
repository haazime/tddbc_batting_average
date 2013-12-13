class BattingAverage
  include Comparable

  class << self

    def format(appearance: appearance, bat: bat, hit: hit)
      new(appearance: appearance, bat: bat, hit: hit)
        .format
    end
  end

  attr_reader :appearance

  def initialize(appearance: appearance, bat: bat, hit: hit)
    @appearance = appearance
    @bat = bat
    @hit = hit
  end

  def value
    @value ||= calculate
  end

  def to_s
    @to_s ||= "%.3f" % value
  end

  def format
    return '----' if nil?
    return '1.00' if value == 1
    to_s.sub(/^0/, '')
  end

  def nil?
    @appearance == 0
  end

  def <=>(other)
    (self.appearance <=> other.appearance).tap do |x|
      break self.value <=> other.value if x == 0
    end
  end

  def ==(other)
    return false unless other.respond_to?(:to_s)
    self.to_s == other.to_s
  end

private

  def calculate
    return 0 if @appearance == 0 or @bat == 0
    @hit.to_f / @bat.to_f
  end
end
