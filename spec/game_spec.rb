require 'spec_helper'
require_relative '../lib/game'
require 'pry'

RSpec.describe 'game' do
  context 'current_player' do
    it 'prints out the current token waiting to make a move' do
      board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      board1 = ['X', 'O', 'X', 'O', 5, 6, 7, 8, 9]
      board2 = ['X', 'O', 'X', 'O', 5, 6, 7, 8, 'X']
      expect(current_player(board)).to eq('X')
      expect(current_player(board1)).to eq('X')
      expect(current_player(board2)).to eq('O')
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
      board = [1, "X", 3, 4, 5, 6, "O", 8, 9]
      expect(valid_play?(1, board)).to eq(true)
    end
    it 'returns false if input is neither a number or within range' do
      board = [1, "X", 3, 4, 5, 6, "O", 8, 9]
      expect(valid_play?(-1, board)).to eq(false)
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
      expect(move(board, 5)).to eq(['X', 'O', 'X', 4, 'O', 6, 7, 8, 9])
    end
  end

# Single Player Easy mode *********************************
  context 'open_squares' do
    it 'returns all the squares that do not currently have a token' do
      board = ['O', 2, 'X', 4, 'X', 6, 'O', 8, 'X']
      expect(open_squares(board)).to eq([2, 4, 6, 8])
    end
  end

  context 'random_square' do
    it 'given a number to test returns that number' do
      available_squares = [2, 4, 6, 8]
      expect(random_square(available_squares, 8)).to eq(8)
    end
    it 'given an array returns a random element in the array' do
      available_squares = [2, 4, 6, 8]
      expect(available_squares[0]..available_squares[-1]).to cover(random_square(available_squares))
    end
  end

# Single Player Unbeatable mode ****************************
  # context 'winning_move' do #this is only called when the player is the computer
  #   it 'returns the square that will result in three in a row for given token' do
  #     board1 = ['X', 'O', 'X', 'X', 'O', 'X', 'O', 8, 9]
  #     board2 = ['X', 'O', 'X', 4, 'X', 'O', 'O', 8, 9]
  #     board3 = ['O', 2, 'O', 'X', 'X', 6, 'X', 8, 9]
  #     board4 = ['X', 'O', 'X', 'X', 'O', 6, 7, 8, 9]
  #     expect(winning_move(board1, 'O')).to eq(8)
  #     expect(winning_move(board2, 'X')).to eq(9)
  #     expect(winning_move(board3, 'O')).to eq(2)
  #     expect(winning_move(board4, 'O')).to eq(8)
  #   end
  # end

  context 'score' do
    it 'returns a min or max score based on status of the board' do
      board1 = ['O', 2, 'X', 'X', 5, 'X', 7, 'O', 'O'] # current player is X
      board2 = ['O', 'X', 'X', 'X', 5, 'X', 7, 'O', 'O'] # current player is O
      board3 = ['O', 2, 'X', 'X', 'X', 'X', 7, 'O', 'O'] # current player is O
      board4 = ['O', 2, 'X', 'X', 5, 'X', 'X', 'O', 'O'] # current player is O
      board5 = ['O', 'X', 'X', 'X', 5, 'X', 'O', 'O', 'O'] # current player is X
      expect(score(board1)).to eq(0)
      expect(score(board2)).to eq(0)
      expect(score(board3)).to eq(-10)
      expect(score(board4)).to eq(0)
      expect(score(board5)).to eq(10)
    end
  end

  context 'minimax' do
    it 'returns the moves and their resulting scores' do
      board1 = ['X', 'X', 'O', 'X', 'X', 'O', 'O', 'O',  9] # current player is X
      board2 = ['X', 'X', 'O','X', 'X', 'O','O', 8,  'O'] # current player is O
      board3 = ['X', 'X', 'O','X', 'X', 'O','O', 8,  9] # current player is O
      board4 = ['X', 2, 'X', 'O', 'O', 6, 7, 8, 9]
      board5 = ['X', 2, 'O', 'O', 'O', 'X', 'X', 8, 'X']
      expect(minimax(board1)).to eq(-10)
      expect(minimax(board2)).to eq(10)
      expect(minimax(board3)).to eq(10)
      expect(minimax(board4)).to eq(-10)
      expect(minimax(board5)).to eq(0)
    end
  end

  context 'optimal_move' do
    it 'returns the move with the optimal score for the current player' do
      board1 = ['X', 'X', 'O','X', 'X', 'O','O', 8,  9]
      board2 = ['X', 2, 3, 4, 5, 6, 7, 8, 9]
      board3 = ['X', 2, 3, 4, 'O', 6, 7, 8, 'X']
      edge_squares = [2, 4, 6, 8]
      expect(optimal_move(board1)).to eq(9)
      expect(optimal_move(board2)).to eq(5)
      expect(edge_squares[0] .. edge_squares[-1]).to cover(optimal_move(board3))
    end
  end

end #RSpec.describe
