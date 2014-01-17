class BattingAverageRanking

  class << self

    def create(players)
      return [] if players.empty?
      new(players.sort_by(&:batting_average))
    end
  end

  def initialize(order)
    @order = order
  end

  def rank(player)
    @order.index(player) + 1
  end

  def each_with_rank
    @order.collect {|player| [player, rank(player)] }.each
  end
end
