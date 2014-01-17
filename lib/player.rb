class Player
  attr_reader :batting_average

  def initialize(name)
    @name = name
    @batting_average = nil
  end

  def score_batting(record)
    @batting_average = BattingAverage.calculate(record)
    self
  end
end
