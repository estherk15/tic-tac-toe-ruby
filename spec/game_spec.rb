require 'spec_helper'
require_relative '../lib/game'
require 'pry'

RSpec.describe 'game' do
  context 'current_player' do
    it 'prints out the current token waiting to make a move' do
      expect(current_player(2)).to eq('O')
      expect(current_player(3)).to eq('X')
    end
  end

  context 'valid_input?' do
    it 'given a number it returns true' do
      expect(valid_input?(2)).to eq(true)
    end
    it 'given a string it returns false' do
      expect(valid_input?("string")).to eq(false)
    end
  end

  context 'valid_number?' do
    it 'given a number between 1 and 9 returns true' do
      expect(valid_number?(1)).to eq(true)
      expect(valid_number?(9)).to eq(true)
      expect(valid_number?(5)).to eq(true)
    end
    it 'given a number outside the range returns false' do
      expect(valid_number?(10)).to eq(false)
      expect(valid_number?(0)).to eq(false)
      expect(valid_number?(-3)).to eq(false)
    end
  end

  context 'empty_spot?' do
    it 'given a valid spot number returns true if there is no token' do
      board = ['X', 'O', 'X', 4, 5, 6, 7, 8, 9]
      expect(empty_spot?(5, board)).to eq(true)
    end
    it 'given a valid spot number returns false if spot already has a token' do
      board = ['X', 'O', 'X', 4, 5, 6, 7, 8, 9]
      expect(empty_spot?(1, board)).to eq(false)
    end
  end

  context 'valid_play?' do
    it 'returns true if input is both a number and within range' do
      expect(valid_play?(1)).to eq(true)
    end
    it 'returns false if input is neither a number or within range' do
      expect(valid_play?(-1)).to eq(false)
    end
  end

  context 'play_count' do
    it 'returns what turn the next move is' do
      board1 = ['X', 'O', 'X', 4, 5, 6, 7, 8, 9]
      board2 = ['X', 'O', 'X', 'O', 5, 6, 7, 8, 'X']
      expect(play_count(board1)).to eq(4)
      expect(play_count(board2)).to eq(6)
    end
  end

  context 'converts input to index number' do
    it 'returns the index position of the input number' do
      expect(to_index(1)).to eq(0)
      expect(to_index(9)).to eq(8)
      expect(to_index(5)).to eq(4)
    end
  end

  context 'full_board?' do
    it 'returns true if all the spots on the board are filled with a token' do
      board = ['X', 'X', 'X', 'O', 'O', 'X', 'O', 'O', 'X']
      expect(full_board?(board)).to eq(true)
    end
    it 'returns false if there are still spots to play' do
      board1 = ['X', 'X', 'X', 'O', 'O', 'X', 'O', 'O', 9]
      board2 = ['X', 'O', 'X', 'O', 5, 6, 7, 8, 'X']
      expect(full_board?(board1)).to eq(false)
      expect(full_board?(board2)).to eq(false)
    end
  end

  context 'winner?' do
    it 'returns true if there is a winning combination' do
      board = ['X', 'X', 'X', 'O', 'X', 'O', 'X', 8, 9]
      expect(winner?(board)).to eq(true)
    end
    it 'returns false if there are no winning combinations' do
      board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 8, 9]
      expect(winner?(board)).to eq(false)
    end
  end

  context 'draw?' do
    it 'returns true if there are no winner and the board is full' do
      board = ['X', 'O', 'X', 'O', 'X', 'X', 'O', 'X', 'O']
      expect(draw?(board)).to eq(true)
    end
  end

  context 'move' do
    it 'replaced the square on the board with token if empty' do
      board = ['X', 'O', 'X', 4, 5, 6, 7, 8, 9]
      expect(move(5, board)).to eq(['X', 'O', 'X', 4, 'O', 6, 7, 8, 9])
    end
  end

# Single Player Easy mode
  context 'open_squares' do
    it 'returns all the squares that do not currently have a token' do
      board = ['O', 2, 'X', 4, 'X', 6, 'O', 8, 'X']
      expect(open_squares(board)).to eq([2, 4, 6, 8])
    end
  end

  # context 'random_square' do
  #   it 'given an array returns a random element in the array' do
  #     available_squares = [2, 4, 6, 8]
  #     expect(random_square(available_squares, 8)).to eq(8)
  #   end
  # end

  context 'random_square' do
    it 'given an array returns a random element in the array' do
      available_squares = [2, 4, 6, 8]
      expect(available_squares[0]..available_squares[-1]).to cover(random_square(available_squares))
      # binding.pry
    end
  end

  


end #RSpec.describe
