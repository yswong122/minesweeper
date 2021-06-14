require_relative "./tile.rb"
class Board

  attr_reader :length, :num_of_bomb, :grid

  def initialize(num_of_bomb)
    @length = 3
    @grid = Array.new(length) { Array.new(length) }
    @num_of_bomb = num_of_bomb
    populate
  end

  def populate
    bomb_array = random_bomb
    grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        grid[i][j] = Tile.new(bomb_array.pop)
      end
    end
  end

  def random_bomb
    bomb_array = Array.new(length * length) { false }
    i = 0
    while i < num_of_bomb
      random_index = rand(0 ... bomb_array.length)
      if bomb_array[random_index] != true
        bomb_array[random_index] = true
        i += 1
      end
    end
    bomb_array
  end

  def render
    puts " " + (0 ... length).to_a.join
    grid.each_with_index do |row,i|
      print i
      row.each do |tile|
        print render_tile(tile)
      end
      puts
    end
  end

  def render_tile(tile)
    if tile.revealed == false
      "*"
    elsif tile.flagged == true
      "F"
    elsif tile.bombed == false
      "_"
    else
      "!"
    end
  end
end