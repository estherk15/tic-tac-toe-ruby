winningCombo = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [7, 5, 3],
]

standard_board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

currentPlay = 1

def current_player(num)
  num % 2 == 0 ? 'O' : 'X'
end

def validate_input(input)
  input.class == Integer ? true : false
end
