# frozen_string_literal: true

require_relative './game.rb'

BOARD = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def welcome
  puts "Let's play Tic Tac Toe!"
  display_board(BOARD)
  print_instructions
  menu
end

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  line = '-----------'
  display = " #{row1}\n #{line}\n #{row2}\n #{line}\n #{row3}"
  puts display
end

def game_over(player)
  if draw?(BOARD)
    puts "It\'s a tie, you\'re both winners! Huzzah!"
  elsif winner?(BOARD)
    puts "Player #{player} is the Winner!!!"
  end
end

def menu
  puts "Please select Player Mode:
    [1] Single Player
    [2] Multi-Player"
  input = gets.chomp
  player_mode(input)
end

def print_instructions
  instructions = "
  When it is your turn, enter the number in the corresponding
  square on the board you want to place your token. For example,
  if you want to place an [X] in the top left corner, you would
  type 1 on your turn.
  "
  puts instructions
end

def player_mode(input)
  case input
  when '1'
    difficulty_mode
    # puts "run single_player"
  when '2'
    multi_player
    # multi_player
  else
    menu
  end
end

def difficulty_mode
  puts "
  Please select difficulty level:
    [1] Easy
    [2] Unbeatable"
  input = gets.chomp
  case input
  when '1'
    single_player_easy
  when '2'
    single_player_unbeatable
  else
    difficulty_mode
  end
end

# def player_prompt(player)
#   prompt = "Player #{player}, your move: "
#   puts prompt
#   input = gets.chomp.to_i
#   if valid_play?(input, BOARD)
#     move(BOARD, input)
#     display_board(BOARD)
#     if winner?(BOARD) || draw?(BOARD)
#       game_over(player)
#     else
#       player = current_player(BOARD)
#       player_prompt(player)
#     end
#   else
#     puts "***Invalid input, please try again***"
#     player_prompt(player)
#   end
# end

def multi_player
  player = current_player(BOARD)
  puts "Player #{player}, your move: "
  input = gets.chomp.to_i
  if valid_play?(input, BOARD)
    move(BOARD, input)
    display_board(BOARD)
    if winner?(BOARD) || draw?(BOARD)
      game_over(player)
    else
      game_mode
    end
  else
    puts '***Invalid input, please try again***'
    multi_player
  end
end

def single_player_easy
  player = current_player(BOARD)
  # binding.pry
  if player == 'X'
    puts "Player #{player}, your move: "
    input = gets.chomp.to_i
    if valid_play?(input, BOARD)
      move(BOARD, input)
      display_board(BOARD)
      if winner?(BOARD) || draw?(BOARD)
        game_over(player)
      else
        player = current_player(BOARD)
        single_player_easy
      end
    else
      puts '***Invalid input, please try again***'
      single_player_easy
    end
  end
  return unless player == 'O'

  computer_move = random_square(BOARD)
  puts "Player #{player}'s move: #{computer_move}"
  move(BOARD, computer_move)
  display_board(BOARD)
  if winner?(BOARD) || draw?(BOARD)
    game_over(player)
  else
    single_player_easy
  end
end

def single_player_unbeatable
  player = current_player(BOARD)
  if player == 'X'
    puts "Player #{player}, your move: "
    input = gets.chomp.to_i
    if valid_play?(input, BOARD)
      move(BOARD, input)
      display_board(BOARD)
      if winner?(BOARD) || draw?(BOARD)
        game_over(player)
      else
        player = current_player(BOARD)
        single_player_unbeatable
      end
    else
      puts '***Invalid input, please try again***'
      single_player_unbeatable
    end
  end
  return unless player == 'O'

  computer_move = optimal_move(BOARD)
  puts "Player #{player}'s move: #{computer_move}"
  move(BOARD, computer_move)
  display_board(BOARD)

  if winner?(BOARD) || draw?(BOARD)
    game_over(player)
  else
    single_player_unbeatable
  end
end
