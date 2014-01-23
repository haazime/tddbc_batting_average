class Player
  attr_reader :batting_average, :team
  attr_writer :batting_score

  def initialize(name, team=nil)
    @name = name
    @team = team
    @batting_score = { appearance: 0 }
  end

  def batting_appearance
    @batting_score[:appearance]
  end

  def batting_average
    @batting_average ||= BattingAverage.calculate(@batting_score)
  end
end
