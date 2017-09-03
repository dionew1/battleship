class Validation

  def upcase_coordinates(coordinates)
    coordinates.upcase
  end

  def split_coordinates(coordinates)
    coordinates.split
  end

  def get_letters(split_coordinates)
    split_coordinates.map do |coordinate|
      coordinate[0]
    end
  end

  def get_numbers(split_coordinates)
    split_coordinates.map do |coordinate|
      coordinate[1]
    end
  end

  def detect_direction(split_coordinates)
    letters = get_letters(split_coordinates)
    numbers = get_numbers(split_coordinates)
    if letters.uniq.length == 1
      "horizontal"
    elsif numbers.uniq.length == 1
      "vertical"
    else
      nil
    end
  end

  def detect_horizontal_wrap(split_coordinates,columns)
    numbers = get_numbers(split_coordinates)
    numbers.include?("1") && numbers.include?(columns.length.to_s)
  end

  def detect_vertical_wrap(split_coordinates, rows)
    letters = get_letters(split_coordinates)
    letters.include?("A") && letters.include?(rows.last)
  end

  def detect_valid_coordinates_length(split_coordinates, ship_length)
    split_coordinates.length == ship_length
  end

  def detect_horizontal_split(split_coordinates)
    sorted = split_coordinates.sort
    numbers = get_numbers(sorted)
    integers = numbers.map do |number|
      number.to_i
    end
    comparison = [*(integers[0]..integers[-1])]
    comparison != integers
  end

  def detect_vertical_split(split_coordinates, rows)
    sorted = split_coordinates.sort
    letters = get_letters(sorted)
    indexes = letters.map do |letter|
      rows.index(letter)
    end
    comparison = [*(indexes[0]..indexes[-1])]
    comparison != indexes
  end

end
