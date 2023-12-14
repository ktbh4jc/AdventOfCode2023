# frozen_string_literal: true

# A class that solves part 1 of https://adventofcode.com/2023/day/3
class Gear1
  def parce_input(input)
    input.split("\n").map(&:strip)
  end

  # Where ABC Size can be a good metric in the long run, I find it cumbersome in smaller applications,
  # especially at first. Given time I would want to clean this up more.
  # rubocop:disable Metrics/AbcSize
  def do_the_thing(input)
    engine = parce_input(input)
    sum = 0
    (0..engine.size - 1).each do |row|
      # Disableing the each/for preference so that I can edit column within the loop
      # rubocop:disable Style/For
      for column in 0..engine[row].size - 1
        next unless engine[row][column].number?

        full_number = find_full_number(engine, row, column)
        neighbors = find_neighbors(engine, row, column, full_number)
        skip_column_ahead_past_digit_count
        sum += full_number if neighbors.has(symbols)
      end
      # rubocop:enable Style/For
    end
  end
  # rubocop:enable Metrics/AbcSize

  # Given a parced engine diagram and the row and column of the start of a number, return the 
  # full number. This method assumes that it always recieves the correct coordinates of the first
  # digit of a number.
  #
  # @param engine [Array[String], #read] a representation of the provided engine
  # @param row [Integer, #read] the row a given number exists on
  # @param column [Integer, #read] the column a given number starts on
  # @return [Integer] the full number starting at enging[row][collumn]
  def find_full_number(engine, row, column) end
end

# Overwrite Integer to include a num_digits function (found on stackoverflow)
class Integer
  def num_digits
    Math.log10(self).to_i + 1
  end
end
