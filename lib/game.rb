# frozen_string_literal: true

require 'pry'

WINNING_COMBOS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
].freeze

def play_count(board)
  count = board.count { |square| square == 'X' || square == 'O' }
  count + 1
end

def current_player(board)
  num = play_count(board)
  num.even? ? 'O' : 'X'
end

def valid_input?(input)
  input.class == Integer
end

def valid_number?(num)
  num <= 9 && num.positive? ? true : false
end

def empty_spot?(square_spot, board)
  index = to_index(square_spot)
  board[index] != 'X' && board[index] != 'O'
end

def valid_play?(num, board)
  valid_input?(num) && valid_number?(num) && board[num - 1].class == Integer
end

def to_index(num)
  num - 1
end

def full_board?(board)
  board.all? { |square| square == 'X' || square == 'O' }
end

def winner?(board)
  winner = false
  WINNING_COMBOS.any? do |combo|
    current_combo = combo.map { |index| board[index] }
    first_two = (current_combo[0] == current_combo[1])
    last_two = current_combo[1] == current_combo[2]
    win_combo = first_two && last_two
    winner = win_combo && (current_combo[0].class == String)
  end
end

def draw?(board)
  full_board?(board) && !winner?(board)
end

def move(board, input)
  token = current_player(board)
  return unless valid_play?(input, board) && empty_spot?(input, board)

  index = to_index(input)
  board[index] = token
  board
end

def open_squares(board)
  board.select { |square| square.class == Integer }
end

def random_square(array, is_test = false)
  is_test || array.sample
end

def score(board)
  player = current_player(board)
  return 0 unless winner?(board)

  player == 'O' ? -10 : 10
end

def minimax(board)
  player = current_player(board) # X or O
  possible_moves = open_squares(board) # Array of empty squares
  best_score = player == 'O' ? -100 : 100 # Placeholder for min/max

  return score(board) if winner?(board) || draw?(board)

  possible_moves.each do |square_num|
    new_board = board.slice(0..-1)
    new_board[square_num - 1] = player
    new_board_score = minimax(new_board)
    if player == 'O' && (best_score < new_board_score)
      best_score = new_board_score
    elsif player == 'X' && (best_score > new_board_score)
      best_score = new_board_score
    end
  end
  best_score
end

def optimal_move(board) 
  player = current_player(board)
  possible_moves = open_squares(board)
  best_move = nil
  best_score = nil

  possible_moves.each do |square_num|
    new_board = board.slice(0..-1)
    new_board[square_num - 1] = player
    score = minimax(new_board)
    if best_score.nil? || score > best_score
      best_score = score
      best_move = square_num
    end
  end
  best_move
end
