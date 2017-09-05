require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'

class BattleshipTest < Minitest::Test

  def test_battleship_exists
    battleship = Battleship.new

    assert_instance_of Battleship, battleship
  end

end
