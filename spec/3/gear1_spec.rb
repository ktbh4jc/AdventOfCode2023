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

  # .find_full_number for the scope of this project will assume good input
  describe '.find_full_number' do
    it 'finds all numbers from test input' do
      gear1 = described_class.new
      tests = { [0, 0] => 467, [0, 5] => 114, [2, 2] => 35, [2, 6] => 633 }
      tests.each_key do |key|
        expect(gear1.find_full_number(TEST_INPUT_PARCED, key[0], key[1])).to eq(tests[key])
      end
    end

    it 'does not crash when a number is at the end of a line' do
      gear1 = described_class.new
      engine = ['..123']
      expect(gear1.find_full_number(engine, 0, 2)).to eq(123)
    end
  end

  describe '.numeric?' do
    it 'returns true when provided with a single character string that is a digit' do
      gear1 = described_class.new
      expect(gear1.numeric?('1')).to eq(true)
    end

    it 'returns false when provided with a multi-character string' do
      gear1 = described_class.new
      expect(gear1.numeric?('11')).to eq(false)
    end

    it 'returns false when provided with a single character string that is not a digit' do
      gear1 = described_class.new
      expect(gear1.numeric?('A')).to eq(false)
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
