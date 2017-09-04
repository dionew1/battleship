require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/validation'

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

  def test_upcase_coordinates_and_split_coordinates
    board = Board.new
    actual = board.split_coordinates(board.upcase_coordinates("a1 a2"))
    expected = ["A1", "A2"]

    assert_equal expected, actual
  end

  def test_choose_random_ship_direction
    board = Board.new
    actual = board.choose_random_ship_direction

    assert ["horizontal", "vertical"].include?(actual)
  end

  def test_choose_horizontal_starting_coordinate_with_ship_length_of_2
    board = Board.new
    actual = board.choose_horizontal_starting_coordinate(2)

    assert board.grid.has_key?(actual)
  end

  def test_choose_horizontal_starting_coordinate_with_ship_length_of_3
    board = Board.new
    actual = board.choose_horizontal_starting_coordinate(3)

    assert board.grid.has_key?(actual)
  end

end
