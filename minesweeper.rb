require_relative "./board.rb"

class MinesweeperGame

  attr_reader :board

  def initialize(num_of_bomb)
    @board = Board.new(num_of_bomb)
  end

  def game_turn
    board.render
    act, pos = get_user_input
    case act
    when "f"
      board.flag(pos)
    when "r"
      board.reveal(pos)
    end
  end

  def run
    until game_end
      game_turn
      if win?
        puts "you win!"
        break
      end
      if lose?
        puts "you lose"
        break
      end
    end
  end

  def game_end
    win? || lose?
  end

  def win?
    all_bomb_tile.all? { |ele| ele.flagged == true }
  end

  def lose?
    all_bomb_tile.any? { |ele| ele.revealed == true }
  end

  def all_bomb_tile
    all_bomb_tile = []
    @board.grid.each do |row|
      row.each do |ele|
        all_bomb_tile << ele if ele.bombed == true
      end
    end
    all_bomb_tile
  end

  def get_user_input
    input = nil
    until input && valid_input?(input)
      puts "enter following command: <action> <location>"
      puts "action: f: flag, r: reveal"
      puts "location eg. 0,2 or 1,1"
      print "> "
      begin 
        input = parse_input(gets.chomp)
        #debugger
        act = input[0]
        pos = parse_pos(input[1])
      rescue => error
        puts "#{error.message}"
        puts ""
        input = nil
      end
    end
    return act, pos
  end

  def parse_input(input)
    input = input.split(" ")
    raise("invalid command") if input.length != 2
    input
  end

  def parse_pos(pos)
    pos = pos.split(",")
    raise("invalid position input") if pos.length != 2
    pos.map!(&:to_i)
    pos
  end

  def valid_input?(input)
    valid_act?(input) && valid_pos?(input)
  end

  def valid_act?(input)
    command_list = ["f","r"]
    command_list.include?(input[0])
  end

  def valid_pos?(input)
    pos = input[1]
    pos = pos.split(",")
    alphabet = ("a" .. "z").to_a
    pos.none? { |ele| alphabet.include?(ele) }
  end
end

game = MinesweeperGame.new(2)
game.run