# frozen_string_literal: true

# A class that solves part 1 of https://adventofcode.com/2023/day/2
class Cube
  MAX_RED = 12
  MAX_GREEN = 13
  MAX_BLUE = 14

  Pull = Struct.new(:red, :green, :blue)
  Game = Struct.new(:id, :pulls) do |_game|
    # Determins if a game is valid
    def valid?
      pulls.each do |pull|
        return false if pull.red > MAX_RED || pull.green > MAX_GREEN || pull.blue > MAX_BLUE
      end
      true
    end
  end

  # Generate a "game" based on the given input and note if it is valid or not.
  # My process is going to be to use the split function to chunk the games into smaller data chunks and then use a few
  # simple regexes to capture the numbers, then use a quick check to see if any of the pulls in a game were over the max
  # values above to determine validity.
  def build_game(game_log)
    # "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  end
end
