require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/timer'

class TimerTest < Minitest::Test
  timer = Timer.new

  assert_instance_of Timer, timer
end
