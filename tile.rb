class Tile

  attr_reader :bombed, :flagged, :revealed

  def initialize(bombed)
    @location = []
    @bombed = bombed
    @flagged = false
    @revealed = true
  end

  def reveal

  end
  
  def neighbors

  end

  def neighbors_bomb_count

  end
end