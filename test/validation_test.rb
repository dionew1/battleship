require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/validation'

class ValidationTest < Minitest::Test

  def test_validation_exists
    validation= Validation.new

    assert_instance_of Validation, validation
  end

  def test_upcase_coordinates
    validation = Validation.new
    actual = validation.upcase_coordinates("a1 a2")
    expected = "A1 A2"

    assert_equal expected, actual
  end

  def test_split_player_coordinates_into_characters
    validation = Validation.new
    actual = validation.split_coordinates("A1 A2")
    expected = ["A1", "A2"]

    assert_equal expected, actual
  end

  def upcase_coordinates
    validation = Validation.new
    actual = validation.split_coordinates(validation.upcase_coordinates("a1 a2"))
    expected = "A1 A2"

    assert_equal expected, actual
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

end
