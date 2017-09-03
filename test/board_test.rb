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

  def test_detect_direction_horizontal_with_2_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "A2"])
    expected = "horizontal"

    assert_equal expected, actual
  end

  def test_detect_direction_vertical_with_2_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "B1"])
    expected = "vertical"

    assert_equal expected, actual
  end

  def test_detect_direction_nil_with_2_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "B2"])

    assert_nil actual
  end

  def test_detect_direction_horizontal_with_3_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "A2", "A3"])
    expected = "horizontal"

    assert_equal expected, actual
  end

  def test_detect_direction_vertical_with_3_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "B1", "C1"])
    expected = "vertical"

    assert_equal expected, actual
  end

  def test_detect_direction_nil_with_3_coordinates
    board = Board.new
    actual = board.detect_direction(["A1", "B2", "C2"])

    assert_nil actual
  end

  def test_detect_horizontal_wrap_with_2_coordinates
    board = Board.new
    actual = board.detect_horizontal_wrap(["A1", "A4"])

    assert actual
  end

  def test_detect_horizontal_wrap_with_3_coordinates
    board = Board.new
    actual = board.detect_horizontal_wrap(["A2", "A1", "A4"])

    assert actual
  end

  def test_detect_vertical_wrap_with_2_coordinates
    board = Board.new
    actual = board.detect_vertical_wrap(["A1", "D1"])

    assert actual
  end

end
