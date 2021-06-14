require_relative "./board.rb"
require "byebug"

class MinesweeperGame

  attr_reader :board

  def initialize
    @board = Board.new(3)
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
    loop do
      game_turn
    end
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

game = MinesweeperGame.new
game.run