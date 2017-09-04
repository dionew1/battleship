require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/validation'
require './lib/ship'

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

  def test_choose_vertical_starting_coordinate_with_ship_length_of_2
    board = Board.new
    actual = board.choose_vertical_starting_coordinate(2)

    assert board.grid.has_key?(actual)
  end

  def test_choose_vertical_starting_coordinate_with_ship_length_of_3
    board = Board.new
    actual = board.choose_vertical_starting_coordinate(3)

    assert board.grid.has_key?(actual)
  end

  def test_get_next_horizontal_coordinate
    board = Board.new
    actual = board.get_next_horizontal_coordinate("A1")

    assert_equal "A2", actual
  end

  def test_get_next_vertical_coordinate
    board = Board.new
    actual = board.get_next_vertical_coordinate("A1")

    assert_equal "B1", actual
  end

  def test_validate_computer_coordinates_with_2_valid
    board = Board.new
    actual = board.validate_computer_coordinates("A1 A2")

    refute actual
  end

  def test_validate_computer_coordinates_with_3_valid
    board = Board.new
    actual = board.validate_computer_coordinates("B1 B2 B3")

    refute actual
  end
  def test_validate_computer_coordinates_with_2_split
    board = Board.new
    actual = board.validate_computer_coordinates("A1 A4")

    assert actual
  end

  def test_validate_computer_coordinates_with_3_invalid
    board = Board.new
    actual = board.validate_computer_coordinates("A1 A2 Z3")

    assert actual
  end

  def test_validate_computer_coordinates_with_3_overlap
    board = Board.new
    board.ships << Ship.new(["A1", "A2"], "horizontal")
    actual = board.validate_computer_coordinates("A1 B2 C3")

    assert actual
  end

  def test_create_computer_coordinates
    board = Board.new
    actual = board.create_computer_coordinates(2)

    assert_equal 5, actual.length
  end

  def test_create_computer_coordinates
    board = Board.new
    actual = board.create_computer_coordinates(3)

    assert_equal 8, actual.length
  end

end
