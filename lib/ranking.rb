class Ranking

  def initialize(players)
    @players = players
  end

  def order_by_batting_average
    @players.sort_by {|p| p.batting_average }.reverse
  end
end
