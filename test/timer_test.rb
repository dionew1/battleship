require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/timer'

class TimerTest < Minitest::Test

  def test_timer_exists
    timer = Timer.new

    assert_instance_of Timer, timer
  end

  def test_time_of_game
    time = Timer.new
    total_time = "This game was played in 1 seconds."
    sleep(0.5)

    assert_equal total_time, time.time_of_game
  end

end
