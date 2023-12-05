# frozen_string_literal: true

# A class that solves part 1 of https://adventofcode.com/2023/day/2
class Cube1
  MAX_RED = 12
  MAX_GREEN = 13
  MAX_BLUE = 14
  ID_REGEX = /Game (?<id>\d+)/
  RED_REGEX = /(?<red>\d+) red/
  GREEN_REGEX = /(?<green>\d+) green/
  BLUE_REGEX = /(?<blue>\d+) blue/

  def initialize
    @games = []
  end

  Pull = Struct.new(:red, :green, :blue)
  Game = Struct.new(:id, :pulls) do
    # Determines if a game is valid by comparing each pull to the max value.
    # This could be simplified if games only stored the highest value for each, but I chose to
    # include every pull for extendability sake.
    #
    # @return true if valid, false otherwise
    def valid?
      pulls.each do |pull|
        return false if pull.red > MAX_RED || pull.green > MAX_GREEN || pull.blue > MAX_BLUE
      end
      true
    end
  end

  # Generate a "game" based on the given input.
  # My process is going to be to use the split function to chunk the games into smaller data chunks and then use a few
  # simple regexes to capture the numbers.
  #
  # @param game_log[String, #read] a string consisting of a single game with multiple pulls.
  #    Formatted as such: "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  # @return [Game] the Game struct that matches a given input string
  def build_game(game_log)
    pulls = []
    game_id = game_log.split(':')[0].match(ID_REGEX)[:id].to_i
    pull_logs = game_log.split(';')
    pull_logs.each do |pull_log|
      pulls << build_pull(pull_log)
    end
    Game.new(game_id, pulls)
  end

  # Generate a "Pull" based on a given input.
  #
  # @param pull_log[String, #read] the context of a provided pull
  # @return [Pull] a Pull showing how many cubes of each color were pulled for a given example
  def build_pull(pull_log)
    red = get_color_value(pull_log, RED_REGEX, :red)
    green = get_color_value(pull_log, GREEN_REGEX, :green)
    blue = get_color_value(pull_log, BLUE_REGEX, :blue)
    Pull.new(red, green, blue)
  end

  # generate a color value based on a provided regex and key
  #
  # @param pull_log[String, #read] The contents of a provided pull
  # @param regex[Regexp, #read] A regex that we are gettting information from
  def get_color_value(pull_log, regex, key)
    val = pull_log.match(regex)
    return 0 if val.nil?

    val[key].to_i
  end

  # Itterate over multi-line input and build out the @games
  #
  # @param input[String, #read] a string consisting of multiple games
  #    Each must be on it's own line and formatted like this:
  #    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  def build_games(input)
    lines = input.split("\n")
    lines.each do |line|
      @games << build_game(line)
    end
  end

  # Itterate over all games and sum the IDs of all valid games
  #
  # @return [Integer] the sum of all valid games' ids
  def sum_valid_games
    sum = 0
    @games.each do |game|
      sum += game.id if game.valid?
    end
    sum
  end

  # Main runner function.
  def play(input)
    build_games(input)
    puts sum_valid_games
  end
end

cube = Cube1.new
# test_input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
# Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
# Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
# Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"

# cube.play test_input

# rubocop:disable Layout/LineLength
full_input = "Game 1: 4 red, 1 green, 15 blue; 6 green, 2 red, 10 blue; 7 blue, 6 green, 4 red; 12 blue, 10 green, 3 red
Game 2: 3 green, 18 blue; 14 green, 4 red, 2 blue; 3 red, 14 green, 15 blue
Game 3: 12 green, 2 blue; 9 green; 1 red, 11 blue, 4 green
Game 4: 4 blue, 8 green, 5 red; 6 red, 7 blue, 9 green; 2 green, 2 red, 2 blue; 2 green, 6 blue, 9 red; 10 red, 9 green
Game 5: 12 red, 1 green, 7 blue; 13 red, 16 blue; 16 blue, 10 red; 4 blue; 16 blue, 7 red; 1 blue, 7 red
Game 6: 17 blue, 2 red; 5 blue, 6 green, 2 red; 5 green, 5 blue; 5 green, 12 blue, 4 red
Game 7: 2 red, 1 blue, 10 green; 8 red, 14 green, 9 blue; 15 red, 1 blue, 6 green; 9 blue, 3 green, 10 red; 7 blue, 13 red, 4 green
Game 8: 1 green, 2 blue; 7 red, 2 blue, 1 green; 1 red, 2 green; 4 red, 1 blue; 11 red, 2 green, 2 blue; 1 blue, 2 green, 11 red
Game 9: 11 green, 11 blue, 6 red; 2 green, 3 blue, 2 red; 2 red, 11 blue, 14 green; 5 green, 7 red, 7 blue; 7 green, 1 red, 12 blue; 1 red, 8 green, 7 blue
Game 10: 2 red, 8 green, 7 blue; 10 red, 5 green, 2 blue; 4 red, 8 green, 16 blue; 10 blue, 3 green, 15 red
Game 11: 2 blue, 2 green, 5 red; 1 green, 3 red, 3 blue; 11 green, 1 red, 2 blue
Game 12: 8 blue, 11 green, 14 red; 10 green, 13 red, 2 blue; 1 red, 6 green, 4 blue; 13 red, 11 green, 6 blue
Game 13: 15 red, 17 green, 1 blue; 12 red, 1 blue, 1 green; 2 red, 1 blue, 14 green
Game 14: 6 green, 11 red, 3 blue; 6 green, 2 blue; 2 green, 10 red, 8 blue; 2 red; 1 green, 9 red; 3 blue, 1 green, 3 red
Game 15: 11 blue, 11 green, 4 red; 3 green, 10 blue; 2 red, 9 green, 9 blue
Game 16: 2 blue, 11 green; 1 red, 1 blue, 11 green; 12 green, 1 blue, 1 red; 3 blue, 14 green, 1 red; 14 green, 4 blue; 2 blue, 12 green
Game 17: 1 red, 2 blue, 4 green; 4 blue, 3 green; 1 green, 1 red, 6 blue; 1 red, 7 blue; 2 green
Game 18: 3 red, 3 blue, 7 green; 2 blue, 2 red, 2 green; 4 red, 12 green; 5 green, 2 blue, 4 red; 3 red
Game 19: 15 red, 7 blue, 10 green; 5 green, 8 red; 9 green, 8 red; 5 red, 10 green
Game 20: 15 blue, 6 green, 11 red; 13 red, 9 blue, 1 green; 15 blue, 10 red, 11 green
Game 21: 15 red, 4 green; 11 red, 2 blue, 4 green; 5 blue, 2 green, 4 red; 4 red, 5 blue; 6 red, 3 blue, 1 green
Game 22: 4 green, 4 red, 13 blue; 3 red, 7 blue, 9 green; 12 blue, 13 green, 5 red
Game 23: 20 green, 4 red; 6 blue, 9 red, 7 green; 6 green
Game 24: 1 green, 3 blue, 6 red; 1 green, 1 blue, 2 red; 3 blue, 5 red, 1 green
Game 25: 2 red, 9 blue, 2 green; 2 green, 1 red, 5 blue; 3 red, 1 green, 3 blue; 8 blue, 2 green, 3 red; 12 blue, 3 red; 1 blue, 2 green, 1 red
Game 26: 2 blue, 5 green, 20 red; 2 blue, 6 red, 9 green; 3 red, 2 blue, 5 green
Game 27: 17 blue, 2 red, 14 green; 15 green, 16 blue, 2 red; 13 blue, 13 green; 1 red, 7 green, 3 blue; 1 blue, 2 green
Game 28: 5 blue, 6 red, 3 green; 7 red, 19 green; 11 blue, 13 green
Game 29: 1 blue, 8 red, 7 green; 1 green, 1 red; 8 red, 7 green, 1 blue; 7 green, 2 red; 1 blue, 7 red; 1 blue, 2 red, 5 green
Game 30: 3 red, 17 blue; 11 red, 3 blue, 8 green; 7 green, 12 blue, 10 red; 5 blue, 2 green
Game 31: 14 blue, 7 green; 12 green, 14 blue, 2 red; 17 blue, 2 red, 8 green; 2 red, 3 blue, 11 green; 9 green, 4 blue; 1 red, 3 green, 1 blue
Game 32: 15 red, 1 blue, 10 green; 15 green, 10 red, 1 blue; 2 red, 6 green, 1 blue
Game 33: 10 green, 1 red, 16 blue; 11 blue, 14 green, 3 red; 14 green, 13 blue; 17 blue, 2 red, 3 green
Game 34: 8 red, 7 blue, 8 green; 3 green, 1 red; 1 red, 1 green, 5 blue; 6 red, 8 green, 2 blue; 7 red, 8 blue, 3 green
Game 35: 5 blue, 19 red; 2 blue, 11 red, 1 green; 16 red, 10 blue; 7 green, 3 blue, 6 red; 3 green, 18 red, 5 blue; 8 blue, 5 red
Game 36: 9 red, 6 green, 10 blue; 9 red, 15 green, 6 blue; 6 red, 1 blue, 14 green
Game 37: 7 green, 8 red, 2 blue; 3 blue, 5 red, 16 green; 1 green, 1 red, 3 blue
Game 38: 5 green, 5 red, 3 blue; 10 blue, 19 red, 9 green; 2 red, 3 blue, 11 green
Game 39: 15 red, 11 blue, 5 green; 11 green, 2 red, 6 blue; 2 blue, 3 green, 6 red; 15 red, 3 blue, 13 green
Game 40: 7 green, 4 red, 1 blue; 6 blue, 6 green, 2 red; 2 blue, 3 red, 1 green; 1 blue, 3 red, 3 green; 2 red, 5 green, 3 blue
Game 41: 10 blue, 8 green, 9 red; 7 blue, 9 red, 2 green; 10 blue, 4 red, 5 green
Game 42: 8 blue, 13 green, 14 red; 8 blue, 1 green, 11 red; 4 red, 6 green, 3 blue; 14 green, 4 red, 2 blue
Game 43: 2 red, 10 green, 19 blue; 5 blue, 4 green, 9 red; 9 green, 9 red, 2 blue
Game 44: 6 red, 2 green, 3 blue; 2 blue, 12 red, 6 green; 1 red, 10 blue; 12 red, 6 green, 2 blue; 14 red, 13 green, 3 blue; 10 green, 9 blue, 11 red
Game 45: 2 blue, 1 red, 1 green; 1 green, 1 blue; 2 green, 2 blue
Game 46: 7 green, 1 red; 1 green, 4 blue, 1 red; 3 blue, 4 green, 1 red; 1 red, 4 green; 1 blue, 12 green, 1 red; 16 green, 1 blue
Game 47: 4 blue, 8 green, 3 red; 6 red, 1 green, 3 blue; 16 green, 4 blue, 1 red; 4 blue, 8 red
Game 48: 1 blue, 9 red, 8 green; 8 green, 2 blue, 6 red; 2 green; 4 blue, 5 red; 1 blue, 9 red, 9 green; 1 red, 1 blue, 3 green
Game 49: 3 green, 2 blue; 7 blue, 4 red; 20 green, 5 red, 13 blue; 20 green, 1 red, 6 blue
Game 50: 3 red, 3 green; 3 green, 3 red; 2 blue, 10 red; 3 blue, 5 green; 14 red, 2 green, 2 blue; 7 red, 2 green
Game 51: 3 green, 3 blue, 2 red; 4 green, 16 red, 3 blue; 1 blue, 3 red; 9 red, 1 blue, 4 green
Game 52: 6 red, 18 green, 7 blue; 2 blue, 1 red, 5 green; 8 blue, 6 red, 1 green; 1 red, 1 blue; 6 red, 3 green, 10 blue
Game 53: 1 blue, 10 red, 3 green; 13 red, 2 green, 1 blue; 1 green, 2 red
Game 54: 4 blue, 6 green, 2 red; 5 blue, 6 red, 2 green; 6 blue, 4 green, 8 red; 13 red, 10 blue, 1 green; 5 red, 5 green, 9 blue
Game 55: 4 green, 18 red, 4 blue; 9 blue, 7 green, 16 red; 5 red, 6 blue, 14 green; 13 green, 11 red, 9 blue; 6 blue, 13 green, 1 red; 10 blue, 12 red, 14 green
Game 56: 8 green, 5 blue, 10 red; 10 green, 7 red, 12 blue; 11 red, 12 blue, 1 green; 4 blue, 6 red, 10 green; 17 blue, 8 green, 2 red
Game 57: 1 green, 2 red; 2 green, 5 red, 1 blue; 13 red, 3 green, 4 blue; 3 blue, 13 red, 9 green
Game 58: 1 red, 7 blue, 4 green; 2 green, 1 blue, 1 red; 1 green, 11 blue; 12 blue; 1 blue, 5 green, 1 red; 3 green, 11 blue, 1 red
Game 59: 5 green, 3 blue, 17 red; 2 red, 9 green; 1 blue, 4 green
Game 60: 5 red, 5 green, 1 blue; 2 red, 2 blue, 6 green; 2 red, 3 blue, 3 green
Game 61: 2 green, 3 blue, 4 red; 17 green, 1 blue; 1 green, 6 red, 4 blue; 3 blue, 9 green, 3 red; 18 green, 7 red, 2 blue
Game 62: 5 red; 3 blue, 9 green; 3 red, 13 blue, 10 green; 14 green, 1 red, 2 blue; 7 blue, 13 green
Game 63: 12 blue, 5 green; 5 green, 1 red, 1 blue; 4 red, 7 green, 9 blue; 8 blue, 2 green, 7 red
Game 64: 3 blue, 11 green; 5 blue, 2 red, 5 green; 17 green, 5 blue, 1 red; 4 red, 3 blue, 4 green
Game 65: 2 red, 1 blue, 2 green; 7 green, 2 red, 1 blue; 2 blue, 7 green, 1 red; 3 blue, 8 green, 3 red
Game 66: 4 red, 12 blue, 1 green; 20 blue, 3 green, 2 red; 11 blue, 1 green
Game 67: 12 blue, 10 red, 13 green; 19 green, 4 red, 7 blue; 12 red, 9 blue, 13 green
Game 68: 2 blue, 17 green; 12 green, 2 red; 5 red, 2 green, 4 blue; 4 blue
Game 69: 17 blue, 3 red, 1 green; 4 green, 8 blue, 8 red; 4 green, 7 red, 1 blue; 8 red, 1 green, 11 blue; 13 blue, 10 red, 9 green; 14 blue, 5 green, 6 red
Game 70: 1 red, 2 blue, 4 green; 13 blue, 3 red, 2 green; 6 green, 8 blue
Game 71: 5 red, 7 green, 1 blue; 11 green, 4 red, 1 blue; 1 red, 12 green, 10 blue; 1 red, 7 blue, 12 green
Game 72: 9 blue, 4 green, 1 red; 6 green, 4 blue; 8 green, 5 blue, 1 red
Game 73: 1 blue, 10 green, 14 red; 4 green; 2 blue, 9 red, 4 green; 2 blue, 13 green; 13 green, 13 red; 7 red, 5 green, 2 blue
Game 74: 3 red, 1 blue, 3 green; 4 green, 1 blue, 1 red; 2 blue, 10 green, 1 red; 1 blue, 3 red, 1 green
Game 75: 1 red, 1 blue, 1 green; 2 red, 1 green, 4 blue; 2 red, 4 blue; 1 blue, 1 red
Game 76: 4 green, 2 blue, 6 red; 7 green, 1 red; 8 green, 4 red
Game 77: 8 green, 7 blue, 5 red; 6 red, 14 green, 7 blue; 8 green, 7 blue; 1 red, 8 green, 8 blue
Game 78: 6 red, 3 blue, 3 green; 7 blue, 10 red; 5 green, 10 blue, 1 red; 3 green, 11 blue, 4 red; 14 red, 9 blue, 2 green; 16 red, 2 green, 12 blue
Game 79: 1 green; 5 green; 11 green, 3 blue, 2 red; 3 blue
Game 80: 2 green, 2 red; 1 blue, 1 green, 1 red; 1 blue, 1 green, 2 red; 2 red; 5 green
Game 81: 10 blue, 2 red, 9 green; 4 red, 12 blue, 5 green; 7 green, 4 blue, 6 red; 1 red, 13 green, 14 blue; 13 green, 11 blue
Game 82: 4 blue, 2 green; 7 blue, 3 green, 5 red; 1 red, 4 blue, 3 green; 5 blue, 1 red, 6 green; 6 green, 4 red; 11 blue, 3 red, 5 green
Game 83: 12 green; 5 red, 8 green; 11 red, 14 green, 1 blue; 9 green, 4 red
Game 84: 5 blue, 1 red; 16 blue, 5 green; 1 red, 9 blue, 3 green; 11 blue; 1 green, 2 blue; 1 red, 7 blue, 4 green
Game 85: 17 red, 5 blue; 18 blue, 2 red, 2 green; 18 blue, 2 green, 8 red
Game 86: 4 red, 1 blue, 11 green; 6 blue, 7 green, 1 red; 3 green, 4 blue; 2 red, 7 blue, 2 green
Game 87: 4 red, 5 blue; 1 green, 15 red, 1 blue; 11 blue, 12 red
Game 88: 11 green, 3 red, 1 blue; 6 green, 1 blue, 1 red; 1 blue, 3 green; 2 blue, 4 green, 2 red
Game 89: 2 green; 1 red, 2 green, 3 blue; 4 blue, 1 red, 10 green; 4 blue, 5 green; 6 blue, 1 red, 10 green
Game 90: 15 red, 7 green, 17 blue; 7 blue, 1 red; 7 green, 6 red, 3 blue
Game 91: 2 blue, 17 red, 6 green; 1 green, 1 blue, 6 red; 6 red, 4 blue; 10 green, 14 red, 1 blue; 7 blue, 10 green, 10 red; 16 red, 11 green, 9 blue
Game 92: 1 green, 8 blue, 4 red; 4 green, 4 red, 4 blue; 1 green, 7 red, 4 blue
Game 93: 11 blue, 12 red, 1 green; 9 blue, 2 green, 5 red; 7 red, 5 blue, 2 green
Game 94: 7 blue, 10 green; 9 green, 9 blue, 2 red; 1 red, 5 green, 4 blue
Game 95: 1 green, 1 blue, 2 red; 6 red; 1 blue; 1 green, 1 blue, 6 red
Game 96: 1 blue, 1 red, 2 green; 4 red, 13 green, 1 blue; 1 blue, 13 green, 5 red; 7 green, 4 red
Game 97: 10 blue, 5 red, 5 green; 4 red, 8 green, 2 blue; 5 red, 2 green, 15 blue; 2 red, 1 green, 4 blue; 2 red, 14 blue; 14 blue, 4 green
Game 98: 11 red, 8 green, 9 blue; 3 blue, 1 green, 14 red; 10 blue, 2 red, 4 green; 7 blue, 11 red, 3 green; 5 red, 12 blue, 4 green; 7 green, 7 blue, 8 red
Game 99: 3 green, 2 blue, 1 red; 15 red, 8 blue, 7 green; 18 red, 12 blue, 2 green
Game 100: 11 red, 1 blue, 2 green; 3 red, 3 green; 1 blue, 8 red, 4 green; 5 green, 5 blue, 1 red; 2 green, 1 red, 6 blue; 2 green, 8 red, 1 blue"
# rubocop:enable Layout/LineLength

cube.play full_input
