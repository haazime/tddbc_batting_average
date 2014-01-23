class BattingAverageRanking

  class << self

    def create(players)
      return nil if players.empty?
      new(players.sort_by(&:batting_average))
    end

    def create_with_appearance_status(players, team_games)
      official, unofficial = partition_players_by_rankable(players, team_games)
      {
        official: create(official),
        unofficial: create(unofficial)
      }
    end

  private

    def partition_players_by_rankable(players, team_games)
      players.partition do |player|
        rankable_player?(player.batting_appearance, team_games[player.current_team])
      end
    end

    def rankable_player?(appearance, team_game)
      (team_game * 3.1).round <= appearance
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
