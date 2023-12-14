# frozen_string_literal: true

require 'rspec'
require './3/gear1'

describe Gear1 do
  before do
    stub_const('TEST_INPUT',
               "467..114..
                ...*......
                ..35..633.
                ......#...
                617*......
                .....+.58.
                ..592.....
                ......755.
                ...$.*....
                .664.598..")
    stub_const('TEST_INPUT_PARCED',
               [
                 '467..114..',
                 '...*......',
                 '..35..633.',
                 '......#...',
                 '617*......',
                 '.....+.58.',
                 '..592.....',
                 '......755.',
                 '...$.*....',
                 '.664.598..'
               ])
  end

  it 'exists' do
    described_class.new
  end

  it 'properly parces a 2d input' do
    gear1 = described_class.new
    engine = gear1.parce_input(TEST_INPUT)
    expect(engine).to eq(TEST_INPUT_PARCED)
  end

  describe '.find_full_number' do
    it 'finds all numbers from test input' do
      tests = { [0, 0] => 467 }
      tests.each_key do |key|
        expect(described_class.find_full_number(TEST_INPUT_PARCED, key[0], key[1])).to eq(tests[key])
      end
    end
  end

  describe Integer do
    it 'correctly says how many digits a number has' do
      tests = { 1 => 1, 10 => 2, 100 => 3, 1_000_000_000 => 10 }
      tests.each_key do |key|
        expect(key.num_digits).to eq(tests[key])
      end
    end
  end
end
