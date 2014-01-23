class Player
  attr_reader :team
  attr_writer :batting_score

  def initialize(name, team=nil)
    @name = name
    @team = team
    @batting_score = nil
  end

  def batting_appearance
    batting_average.appearance
  end

  def batting_average
    @batting_average ||= BattingAverage.calculate(@batting_score)
  end
end
