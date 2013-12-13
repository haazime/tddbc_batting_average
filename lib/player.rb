class Player
  attr_reader :batting_average

  def initialize(name)
    @name = name
    @batting_average = nil
  end

  def score_batting_average(appearance: appearance, bat: bat, hit: hit)
    @batting_average = BattingAverage.new(appearance: appearance, bat: bat, hit: hit)
    self
  end
end
