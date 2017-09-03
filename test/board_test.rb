require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test

  def test_board_exists
    board= Board.new

    assert_instance_of Board, board
  end

  def test_upcase_coordinates
    board = Board.new
    actual = board.upcase_coordinates("a1 a2")
    expected = "A1 A2"

    assert_equal expected, actual
  end

  def test_split_player_coordinates_into_characters
    board = Board.new
    actual = board.split_coordinates("A1 A2")
    expected = ["A1", "A2"]

    assert_equal expected, actual
  end

  def upcase_coordinates
    board = Board.new
    actual = board.split_coordinates(board.upcase_coordinates("a1 a2"))
    expected = "A1 A2"

    assert_equal expected, actual
  end

  def test_get_letters
    board = Board.new
    actual = board.get_letters(["A1", "A2"])
    expected = ["A", "A"]

    assert_equal expected, actual
  end

  def test_get_numbers
    board = Board.new
    actual = board.get_numbers(["A1", "A2"])
    expected =["1", "2"]

    assert_equal expected, actual
  end

  def test_detect_direction
    skip
    board = Board.new
    expected = "horizontal"
    actual = board.detect_direction(["A1", "A2"])

    assert_equal expected, actual
  end

end
