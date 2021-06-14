class Tile

  attr_reader :bombed, :flagged, :revealed, :grid

  def initialize(board, bombed)
    @grid = board.grid
    @bombed = bombed
    @flagged = false
    @revealed = true
  end

  def reveal
    @revealed = true
    return false if bombed == true
    true
  end
  
  def neighbors
    # find self index
    self_x = 0
    self_y = 0
    grid.each_with_index do |row, i|
      col_index = row.index(self)
      if col_index != nil
        self_x = i
        self_y = col_index
      end
    end
    neighbors_index = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    neighbors_obj = []
    neighbors_index.each do |index|
      nei_x = index[0]
      nei_y = index[1]
      # bordercase
      next if self_x + nei_x < 0 || 
       self_y + nei_y < 0 || 
       self_x + nei_x >= grid.length ||
       self_y + nei_y >= grid.length
      neighbors_obj << grid[self_x + nei_x][self_y + nei_y]
    end
    neighbors_obj
  end

  def neighbors_bomb_count
    count = neighbors.count { |tile| tile.bombed == true }
    return "_" if count == 0
    count
  end

  def flag
    return @flagged = false if @flagged == true
    return @flagged = true if @flagged == false
  end
end

