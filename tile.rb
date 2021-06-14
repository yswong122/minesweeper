class Tile

  attr_reader :bombed, :flagged, :revealed

  def initialize(bombed)
    @bombed = bombed
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
    return false if bombed == true
    true
  end
  
  def neighbors
    
  end

  def neighbors_bomb_count

  end

  def flag
    return @flagged = false if @flagged == true
    return @flagged = true if @flagged == false
  end
end