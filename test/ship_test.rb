require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_ship_exists
    ship = Ship.new

    assert_instance_of Ship, ship
  end

end
