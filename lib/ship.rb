class Ship
  attr_reader :location, :hits

  def initialize(location)
    @location = location
    @hits = []
  end

end
