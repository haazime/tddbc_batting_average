require 'player_ranking'

module BattingAverageRanking
  class RankPolicy

    def initialize(team_games)
      @team_games = team_games
    end

    def satisfied_by?(player)
      player.batting_appearance >= rankable_batting_appearance(player.team)
    end

  private

    def rankable_batting_appearance(team)
      (@team_games[team] * 3.1).round
    end
  end

  class << self

    def create(players)
      return nil if players.empty?
      PlayerRanking.new(players.sort_by(&:batting_average))
    end

    def create_with_appearance_status(players, team_games)
      official, unofficial = partition_players_by_policy(players, team_games)
      {
        official: create(official),
        unofficial: create(unofficial)
      }
    end

  private

    def partition_players_by_policy(players, team_games)
      policy = RankPolicy.new(team_games)
      players.partition {|player| policy.satisfied_by?(player) }
    end
  end
end
