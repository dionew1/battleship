require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/validation'
require './lib/ship'

class ValidationTest < Minitest::Test

  def test_validation_exists
    validation= Validation.new

    assert_instance_of Validation, validation
  end

  def test_get_letters
    validation = Validation.new
    actual = validation.get_letters(["A1", "A2"])
    expected = ["A", "A"]

    assert_equal expected, actual
  end

  def test_get_numbers
    validation = Validation.new
    actual = validation.get_numbers(["A1", "A2"])
    expected =["1", "2"]

    assert_equal expected, actual
  end

  def test_detect_direction_horizontal_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "A2"])
    expected = "horizontal"

    assert_equal expected, actual
  end

  def test_detect_direction_vertical_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "B1"])
    expected = "vertical"

    assert_equal expected, actual
  end

  def test_detect_direction_nil_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "B2"])

    assert_nil actual
  end

  def test_detect_direction_horizontal_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "A2", "A3"])
    expected = "horizontal"

    assert_equal expected, actual
  end

  def test_detect_direction_vertical_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "B1", "C1"])
    expected = "vertical"

    assert_equal expected, actual
  end

  def test_detect_direction_nil_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_direction(["A1", "B2", "C2"])

    assert_nil actual
  end

  def test_detect_horizontal_wrap_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_wrap(["A1", "A4"], [1, 2, 3, 4])

    assert actual
  end

  def test_detect_horizontal_wrap_with_2_valid_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_wrap(["A1", "A2"], [1, 2, 3, 4])

    refute actual
  end

  def test_detect_horizontal_wrap_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_wrap(["A2", "A1", "A4"], [1, 2, 3, 4])

    assert actual
  end

  def test_detect_horizontal_wrap_with_3_valid_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_wrap(["A2", "A1", "A3"], [1, 2, 3, 4])

    refute actual
  end

  def test_detect_vertical_wrap_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_wrap(["A1", "D1"], ["A", "B", "C", "D"])

    assert actual
  end

  def test_detect_vertical_wrap_with_2_valid_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_wrap(["A1", "B1"], ["A", "B", "C", "D"])

    refute actual
  end

  def test_detect_vertical_wrap_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_wrap(["A1", "C1", "D1"], ["A", "B", "C", "D"])

    assert actual
  end

  def test_detect_vertical_wrap_with_3_valid_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_wrap(["A1", "C1", "B1"], ["A", "B", "C", "D"])

    refute actual
  end

  def test_detect_valid_length_of_coordinates_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_valid_coordinates_length(["A1", "A2"], 2)

    assert actual
  end

  def test_detect_valid_length_of_coordinates_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_valid_coordinates_length(["A1", "A2", "A3"], 3)

    assert actual
  end

  def test_detect_valid_length_of_coordinates_with_2_coordinates_and_invalid_length
    validation = Validation.new
    actual = validation.detect_valid_coordinates_length(["A1", "A2", "A3", "A4"], 2)

    refute actual
  end

  def test_detect_horizontal_split_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_split(["A1", "A3"])

    assert actual
  end

  def test_detect_horizontal_split_with_2_valid_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_split(["A1", "A2"])

    refute actual
  end

  def test_detect_horizontal_split_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_split(["A1", "A3", "A4"])

    assert actual
  end

  def test_detect_horizontal_split_with_3_valid_coordinates
    validation = Validation.new
    actual = validation.detect_horizontal_split(["A1", "A3", "A2"])

    refute actual
  end

  def test_detect_vertical_split_with_2_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_split(["A1", "C1"], ["A", "B", "C", "D"])

    assert actual
  end

  def test_detect_vertical_split_with_2_valid_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_split(["A1", "B1"], ["A", "B", "C", "D"])

    refute actual
  end

  def test_detect_vertical_split_with_3_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_split(["A1", "C1", "D1"], ["A", "B", "C", "D"])

    assert actual
  end


  def test_detect_vertical_split_with_3_valid_coordinates
    validation = Validation.new
    actual = validation.detect_vertical_split(["A1", "C1", "B1"], ["A", "B", "C", "D"])

    refute actual
  end

  def test_detect_number_exists
    validation = Validation.new
    actual = validation.detect_number_exists_on_board(["A1", "A6"], [1, 2, 3, 4] )

    refute actual
  end

  def test_detect_number_exists_with_valid_coordinates
    validation = Validation.new
    actual = validation.detect_number_exists_on_board(["A1", "A2"], [1, 2, 3, 4] )

    assert_nil actual
  end

  def test_detect_letter_exists
    validation = Validation.new
    actual = validation.detect_letter_exists_on_board(["A1", "E4"], ["A", "B", "C", "D"])

    refute actual
  end

  def test_detect_letter_exists_with_valid_coordinates
    validation = Validation.new
    actual = validation.detect_letter_exists_on_board(["A1", "A2"], ["A", "B", "C", "D"] )

    assert_nil actual
  end

  def test_detect_overlap_with_one_ship
    validation = Validation.new
    ship = Ship.new(["A1", "A2"], "horizontal")
    actual = validation.detect_overlap(["A1", "B1"], [ship])

    assert actual
  end

  def test_detect_overlap_with_no_ship
    validation = Validation.new
    actual = validation.detect_overlap(["A1", "B1"], [])

    refute actual
  end

  def test_detect_duplicate_coordinate
    validation = Validation.new
    actual = validation.detect_duplicate_coordinate(["A1", "A1"])

    assert actual
  end

  def test_detect_duplicate_coordinate_valid_coordinates
    validation = Validation.new
    actual = validation.detect_duplicate_coordinate(["A1", "A2"])

    refute actual
  end

end
