# frozen_string_literal: true

class Cube
  @@max_red = 12
  @@max_green = 13
  @@max_blue = 14

  Pull = Struct.new(:red, :green, :blue)
  Game = Struct.new(:id, :pulls) do |_game|
    def is_valid
      pulls.each do |pull|
        return false if pull.red > @@max_red || pull.green > @@max_green || pull.blue > @@max_blue
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
