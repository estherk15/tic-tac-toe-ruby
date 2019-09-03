require_relative './game.rb'

BOARD = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def display_board(board)
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  line = '-----------';
  display = " #{row1}\n #{line}\n #{row2}\n #{line}\n #{row3}"
  puts display
end

def welcome
  puts "Let's play Tic Tac Toe!"
  menu
end

def menu
  puts "Please select Player Mode:
    [1] Single Player
    [2] Multi-Player"
  input = gets.chomp
  player_mode(input)
end

def player_mode(input)
  case input
  when "1"
    single_player
    # puts "run single_player"
  when "2"
    puts "run multi_player"
    # multi_player
  else
    menu
  end
end

def print_instructions
  instructions = "\nWhen it is your turn, enter the number in the corresponding\nsquare on the board you want to place your token. For example, \nif you want to place an [X] in the top left corner, you would\ntype 1 on your turn.\n"
  puts instructions
end

def single_player
  display_board(BOARD)
  print_instructions
  difficulty_mode
end

def difficulty_mode
  puts "Please select difficulty level:
    [1] Easy
    [2] Unbeatable"
  input = gets.chomp
  case input
  when "1"
    single_player_easy
  when "2"
    single_player_unbeatable
  else
    difficulty_mode
  end
end

def single_player_easy
  
end
