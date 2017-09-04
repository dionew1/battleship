class Ship
  attr_reader :location, :hits

  def initialize(location, direction)
    @location = location
    @hits = []
    @direction = direction
  end

end
