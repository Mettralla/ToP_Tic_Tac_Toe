# frozen_string_literal: true

# Player class
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end

# Game class
class Game
  @@victory_conditions = {
    a_row: { a1: 2, a2: 0, b1: 2, b2: 1, c1: 2, c2: 2 }, b_row: { a1: 6, a2: 0, b1: 6, b2: 1, c1: 6, c2: 2 },
    c_row: { a1: 10, a2: 0, b1: 10, b2: 1, c1: 10, c2: 2 }, a_col: { a1: 2, a2: 0, b1: 6, b2: 0, c1: 10, c2: 0 },
    b_col: { a1: 2, a2: 1, b1: 6, b2: 1, c1: 10, c2: 1 }, c_col: { a1: 2, a2: 2, b1: 6, b2: 2, c1: 10, c2: 2 },
    dsc_dgl: { a1: 2, a2: 0, b1: 6, b2: 1, c1: 10, c2: 2 }, asc_dgl: { a1: 10, a2: 0, b1: 6, b2: 1, c1: 2, c2: 2 }
  }

  def initialize
    @grid = [
      [' _____ ', ' _____ ', ' _____ '], ['|     |', '|     |', '|     |'], ['|     |', '|     |', '|     |'],
      ['|__1__|', '|__2__|', '|__3__|'], [' _____ ', ' _____ ', ' _____ '], ['|     |', '|     |', '|     |'],
      ['|     |', '|     |', '|     |'], ['|__4__|', '|__5__|', '|__6__|'], [' _____ ', ' _____ ', ' _____ '],
      ['|     |', '|     |', '|     |'], ['|     |', '|     |', '|     |'], ['|__7__|', '|__8__|', '|__9__|']
    ]
    @options = []
  end

  def draw
    @grid.each do |line|
      puts line.join('')
    end
  end

  def did_i_win?(player)
    win = false
    @@victory_conditions.each do |_condition, value|
      space1 = @grid[value[:a1]][value[:a2]]
      space2 = @grid[value[:b1]][value[:b2]]
      space3 = @grid[value[:c1]][value[:c2]]
      space1.include?(player.mark) && space2.include?(player.mark) && space3.include?(player.mark) ? win = true : next
    end
    win
  end

  def select_number(player)
    while true
      print "#{player.name} pick a number of the grid (1 - 9): "
      option = gets.to_i
      option >= 0 && option <= 9 && @options.include?(option) == false ? break : 'Invalid or Taken'
    end
    @options << option
    option
  end

  def place_mark(player, option)
    case option
    when 1..3
      @grid[2][option - 1] == '|     |' ? @grid[2][option - 1] = "|  #{player.mark}  |" : 'Invalid'
    when 4..6
      @grid[6][option - 4] == '|     |' ? @grid[6][option - 4] = "|  #{player.mark}  |" : 'Invalid'
    when 7..9
      @grid[10][option - 7] == '|     |' ? @grid[10][option - 7] = "|  #{player.mark}  |" : 'Invalid'
    end
  end
end

def create_player(mark)
  print 'Choose Player Name: '
  player_name = gets.to_s.chomp
  Player.new(player_name, mark)
end

def tic_tac_toe(players, game)
  victory = false
  current_player = 0
  while victory == false
    game.draw
    p_option = game.select_number(players[current_player])
    game.place_mark(players[current_player], p_option)
    victory = game.did_i_win?(players[current_player])
    if victory == true
      game.draw
      puts "#{players[current_player].name} has won!"
    else
      current_player = (current_player + 1) % 2
    end
  end
end

players = []
players << create_player('X')
players << create_player('O')
round1 = Game.new
tic_tac_toe(players, round1)
