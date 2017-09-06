class Ship
  attr_reader :location
  attr_accessor :hits

  def initialize(location, direction)
    @location = location
    @hits = []
    @direction = direction
  end

  def sunk?
    @hits.length == @location.length
  end

end
