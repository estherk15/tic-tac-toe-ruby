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
]

board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def play_count(board)
  count = board.count {|square| square == 'X' || square == 'O'}
  count + 1
end

def current_player(num)
  num % 2 == 0 ? 'O' : 'X'
end

def valid_input?(input)
  input.class == Integer ? true : false
end

def valid_number?(num)
  num <= 9 && num > 0 ? true : false
end

def empty_spot?(square_spot, board)
  index = to_index(square_spot)
  board[index] != 'X' && board[index] != 'O'
end

def valid_play?(num)
  valid_input?(num) && valid_number?(num)
end

def to_index(num)
  num - 1
end

def full_board?(board)
  board.all? {|square| square == 'X' || square == 'O'}
end

def winner?(board)
  winner = false

  WINNING_COMBOS.any? do |combo|
    current_combo = combo.map {|index| board[index]}
    three_in_a_row = ((current_combo[0] == current_combo[1]) && (current_combo[1] == current_combo[2]))
    winner = three_in_a_row && (current_combo[0].class == String)
  end
  winner
end

def draw?(board)
  draw = full_board?(board) && !winner?(board)
end

def move(board, input)
  turn = play_count(board)
  token = current_player(turn)
  if valid_play?(input) && empty_spot?(input, board)
    index = to_index(input)
    board[index] = token
    board
  end
end

def open_squares(board)
  board.select { |square| square.class == Integer }
end

def random_square(array, isTest=false)
  isTest ? isTest : array.sample
end

def winning_move(board, token) # has the possibility to return a nil value
  possible_moves = open_squares(board)
  next_move = nil

  possible_moves.each do |square_num|
    copy_board = board.slice(0 .. -1)
    copy_board[square_num - 1] = token
    if winner?(copy_board)
       next_move = square_num
    end
  end
  return next_move
end

def minimax(board, max_player)
  human = 'X'
  ai = 'O'
  possible_moves = open_squares(board)
  moves = {} # collects each move's square number and score
  best_move = nil
  if(winner?(board) || draw?(board))
    return board # return game_over method after you write it
  end

  if(max_player)
    value
end
