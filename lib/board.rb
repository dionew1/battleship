class Board

attr_reader :grid, :rows, :columns
attr_accessor :ships

  def initialize
    @grid = {"A1" => nil, "A2" => nil, "A3" => nil, "A4" => nil,
            "B1" => nil, "B2" => nil, "B3" => nil, "B4" => nil,
            "C1" => nil, "C2" => nil, "C3" => nil, "C4" => nil,
            "D1" => nil, "D2" => nil, "D3" => nil, "D4" => nil}
    @rows = ["A", "B", "C", "D"]
    @columns = [1, 2, 3, 4]
    @ships = []
    @validation = Validation.new
  end

  def upcase_coordinates(coordinates)
    coordinates.upcase
  end

  def split_coordinates(coordinates)
    coordinates.split
  end

  def choose_random_ship_direction
    ["horizontal", "vertical"][rand(2)]
  end

  def choose_horizontal_starting_coordinate(ship_length)
    columns_to_keep = @columns.length - (ship_length - 1)
    numbers = @columns.take(columns_to_keep)
    number = numbers[rand(numbers.length)]
    letter = @rows[rand(@rows.length)]
    letter + number.to_s
  end

  def choose_vertical_starting_coordinate(ship_length)
    rows_to_keep = @rows.length - (ship_length - 1)
    letters = @rows.take(rows_to_keep)
    letter = letters[rand(letters.length)]
    number = @columns[rand(@columns.length)]
    letter + number.to_s
  end

  def get_next_horizontal_coordinate(starting_coordinate)
    next_coordinate_number = starting_coordinate[1].to_i + 1
    starting_coordinate[0] + next_coordinate_number.to_s
  end

  def get_next_vertical_coordinate(starting_coordinate)
    next_coordinate_letter = @rows[@rows.index(starting_coordinate[0]) + 1]
    next_coordinate_letter + starting_coordinate[1]
  end

  def validate_computer_coordinates(coordinates)
    split_coordinates = split_coordinates(coordinates)
    direction = @validation.detect_direction(split_coordinates)
    results = []
    results << @validation.detect_number_exists_on_board(split_coordinates, @columns)
    results << @validation.detect_letter_exists_on_board(split_coordinates, @rows)
    results << @validation.detect_overlap(split_coordinates, @ships)
    results << @validation.detect_duplicate_coordinate(split_coordinates)
    results << @validation.detect_invalid_coordinates_length(split_coordinates, split_coordinates.length)
    if direction == "horizontal"
      results << @validation.detect_horizontal_wrap(split_coordinates,@columns)
      results << @validation.detect_horizontal_split(split_coordinates)
    else
      results << @validation.detect_vertical_wrap(split_coordinates, @rows)
      results << @validation.detect_vertical_split(split_coordinates, @rows)
    end
    results.any?
  end

  def create_horizontal_computer_coordinates(ship_length)
    coordinates = []
    coordinate_1 = choose_horizontal_starting_coordinate(ship_length)
    coordinates << coordinate_1
    (ship_length - 1).times do
      coordinates << next_coordinate = get_next_horizontal_coordinate(coordinate_1)
      coordinate_1 = next_coordinate
    end
    coordinates.join(" ")
  end

  def create_vertical_computer_coordinates(ship_length)
    coordinates = []
    coordinate_1 = choose_vertical_starting_coordinate(ship_length)
    coordinates << coordinate_1
    (ship_length - 1).times do
      coordinates << next_coordinate = get_next_vertical_coordinate(coordinate_1)
      coordinate_1 = next_coordinate
    end
    coordinates.join(" ")
  end

  def create_computer_coordinates(ship_length)
    direction = choose_random_ship_direction
    if "horizontal" == direction
      create_horizontal_computer_coordinates(ship_length)
    else
      create_vertical_computer_coordinates(ship_length)
    end
  end

end
