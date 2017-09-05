require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_exists
    player = Player.new

    assert_instance_of Player, player
  end

end
