class Validation

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

  def detect_number_exists_on_board(split_coordinates, columns)
    numbers = get_numbers(split_coordinates)
    valid_numbers = numbers.map do |number|
      columns.include?(number.to_i)
    end
      valid_numbers.find {|value| value == false}
  end


  def detect_letter_exists_on_board(split_coordinates, rows)
    letters = get_letters(split_coordinates)
    valid_letters = letters.map do |letter|
      rows.include?(letter)
    end
      valid_letters.find {|value| value == false}
  end

  def detect_overlap(split_coordinates, ships)
    overlap = split_coordinates.map do |coordinate|
      ships.map {|ship| ship.location.include?(coordinate)}
    end
    overlap.flatten.include?(true)
  end

  def detect_duplicate_coordinate(split_coordinates)
    split_coordinates.uniq != split_coordinates
  end

end
