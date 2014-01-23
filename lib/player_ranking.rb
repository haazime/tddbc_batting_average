class PlayerRanking

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
