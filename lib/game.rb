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

def current_player(board)
  num = play_count(board)
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
    current_combo = combo.map {|index| board[index]} # This is a new array of the square numbers corresponding to the index numbers listed in WINNING_COMBOS
    three_in_a_row = ((current_combo[0] == current_combo[1]) && (current_combo[1] == current_combo[2]))
    winner = three_in_a_row && (current_combo[0].class == String)
  end
end

def draw?(board)
  draw = full_board?(board) && !winner?(board)
end

def move(board, input)
  token = current_player(board)
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

def score(board)
  # you're checking for a win prior to the current player making a move, so you want to see if the previous player has won or not.
  player = current_player(board)
  if winner?(board)
    player == 'O'? -10 : 10
    # if there's a winner and the current player is O, then that means X has won. -10 :(
  else
    return 0
  end
end

def minimax(board) # Returns the optimal score of the board
  # return score(board) if game_over
  player = current_player(board)
  possible_moves = open_squares(board) # Array of square_nums NOT indexes
  best_score = player == 'O'? -Float::INFINITY : Float::INFINITY
  best_move = nil

  # check if there's a winner or it's a tie
  if winner?(board) || draw?(board)
    return score(board)
  end
  possible_moves.each do |square_num|
    new_board = board.slice(0 .. -1)
    new_board[square_num - 1] = player # O
    new_board_score = minimax(new_board)# 10

    if player == 'O'
      if best_score < new_board_score
        best_score = new_board_score
        best_move = square_num
      end
    elsif player == 'X'
      if best_score > new_board_score
        best_score = new_board_score
        best_move = square_num
      end
    end
  end
  best_score
end

def optimal_move(board) # Needs to return a space that will return an optimal move using minimax
  player = current_player(board)
  possible_moves = open_squares(board)
  best_move = nil
  best_score = nil

  possible_moves.each do |square_num|
    new_board = board.slice(0 .. -1)
    new_board[square_num - 1] = player
    score = minimax(new_board)
    if best_score == nil || score > best_score
      best_score = score
      best_move = square_num
    end
  end
    best_move
end
