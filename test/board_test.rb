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
    board.ships << Ship.new(["A1", "A2"], "horizontal")
    actual = board.create_computer_coordinates(3)

    assert_equal 8, actual.length
  end


  def test_create_vertical_computer_coordinates
    board = Board.new
    actual = board.create_vertical_computer_coordinates(2)

    assert_equal 5, actual.length
  end

  def test_create_horizontal_computer_coordinates
    board = Board.new
    actual = board.create_horizontal_computer_coordinates(2)

    assert_equal 5, actual.length
  end

  def test_create_coordinates_on_direction
    board = Board.new
    actual = board.create_coordinates_on_direction(2)

    assert_equal 5, actual.length
  end

  def test_create_ship
    board = Board.new
    board.create_computer_ship(2)

    assert_equal 1, board.ships.length
  end

  def test_create_ship_with_two
    board = Board.new
    board.create_computer_ship(2)
    board.create_computer_ship(3)

    assert_equal 2, board.ships.length
  end

  def test_ship_location_with_1_ship
    board = Board.new
    ship_1 = board.create_computer_ship(2)

    assert_equal 2, ship_1.location.length
  end

  def test_ship_location_with_2_ships
    board = Board.new
    ship_1 = board.create_computer_ship(2)
    ship_2 = board.create_computer_ship(3)

    assert_equal 3, ship_2.location.length
  end

  def test_assign_ship_to_grid
    board = Board.new
    ship_1 = board.create_computer_ship(2)
    ship_2 = board.create_computer_ship(3)
    board.assign_ships_to_grid

    assert_equal 5, board.grid.compact.length
  end

  def test_display_grid
    board = Board.new

    assert_equal "==============" + "\n" +
                 ".  1  2  3  4" + "\n" +
                 "A              " + "\n" +
                 "B              " + "\n" +
                 "C              " + "\n" +
                 "D              " + "\n" +
                 "==============", board.display_grid
  end

  def test_validate_human_coordinates
    board = Board.new
    actual = board.validate_human_coordinates("A1 A2")

    assert_equal "", actual
  end

  def test_validate_human_coordinates_wrap
    board = Board.new
    actual = board.validate_human_coordinates("A1 A4")

    assert_equal "Cannot wrap ship around board, please re-enter coordinates.\nSplit coordinates, please re-enter valid coordinates.", actual
  end

  def test_validate_human_coordinates_split
    board = Board.new
    actual = board.validate_human_coordinates("A1 C1")

    assert_equal "Split coordinates, please re-enter valid coordinates.", actual
  end

  def test_validate_human_coordinates_overlap
    board = Board.new
    board.ships << Ship.new(["A1", "A2"], "horizontal")
    actual = board.validate_human_coordinates("A1 B2")

    assert_equal "Two ships cannot reside in the same coordinate.", actual
  end


end
