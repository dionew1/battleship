require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_ship_exists
    ship = Ship.new("A1 A2", "horizontal")

    assert_instance_of Ship, ship
  end

  def test_true_sunk?
    ship = Ship.new(["A1", "A2"], "horizontal")
    ship.hits << "A1"
    ship.hits << "A2"
    assert ship.sunk?
  end

  def test_false_sunk?
    ship = Ship.new("A1 A2", "horizontal")

    refute ship.sunk?
  end
  
end
