class Board

attr_reader :grid, :rows, :columns, :current_grid
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
    @current_grid = ("=" * 14) + "\n" + ".  " + @columns.join("  ") + "\n"
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
    results << @validation.detect_number_does_not_exist_on_board(split_coordinates, @columns)
    results << @validation.detect_letter_does_not_exist_on_board(split_coordinates, @rows)
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

  def create_coordinates_on_direction(ship_length)
    direction = choose_random_ship_direction
    coordinates = ""
    if "horizontal" == direction
      coordinates = create_horizontal_computer_coordinates(ship_length)
    else
      coordinates = create_vertical_computer_coordinates(ship_length)
    end
    coordinates
  end

  def create_computer_coordinates(ship_length)
    coordinates = create_coordinates_on_direction(ship_length)
    if validate_computer_coordinates(coordinates)
      coordinates = create_computer_coordinates(ship_length)
    end
    coordinates
  end

  def create_computer_ship(ship_length)
    ship_coordinates = create_computer_coordinates(ship_length)
    split_ship_coordinates = split_coordinates(ship_coordinates)
    direction = @validation.detect_direction(split_ship_coordinates)
    ship = Ship.new(split_ship_coordinates, direction)
    @ships << ship
    ship
  end

  def assign_ships_to_grid
    @ships.each do |ship|
      ship.location.each do |coordinate|
        @grid[coordinate] = ship
      end
    end
  end

  def review_value_for_grid(value, coordinate)
    if value == nil
      @current_grid += " "
    elsif value == "M"
      @current_grid += "M"
    elsif value.hits.include?(coordinate)
      @current_grid += "H"
    end
  end

  def review_columns_for_display(row)
    @columns.each do |column|
      coordinate = row+column.to_s
      value = @grid[coordinate]
      review_value_for_grid(value, coordinate)
      @current_grid += "  "
    end
  end

  def display_grid
    boarder = "=" * 14
    @rows.each do |row|
      @current_grid += row + "  "
      review_columns_for_display(row)
      @current_grid += "\n"
    end
    @current_grid += boarder
  end

  def validate_human_coordinates(coordinates, ship_length)
    split_coordinates = split_coordinates(coordinates)
    direction = @validation.detect_direction(split_coordinates)
    results = []
    results << @validation.detect_number_does_not_exist_on_board_with_error(split_coordinates, @columns)
    results << @validation.detect_letter_does_not_exist_on_board_with_error(split_coordinates, @rows)
    results << @validation.detect_overlap_with_error(split_coordinates, @ships)
    results << @validation.detect_duplicate_coordinate_with_error(split_coordinates)
    results << @validation.detect_invalid_coordinates_length_with_error(split_coordinates, ship_length)
    if direction == "horizontal"
      results << @validation.detect_horizontal_wrap_with_error(split_coordinates,@columns)
      results << @validation.detect_horizontal_split_with_error(split_coordinates)
    else
      results << @validation.detect_vertical_wrap_with_error(split_coordinates, @rows)
      results << @validation.detect_vertical_split_with_error(split_coordinates, @rows)
    end
    results.compact.uniq.join("\n")
  end

  def create_human_ship(coordinates)
      split_ship_coordinates = split_coordinates(coordinates)
      direction = @validation.detect_direction(split_ship_coordinates)
      ship = Ship.new(split_ship_coordinates, direction)
      @ships << ship
      ship
  end

  def create_valid_human_ship(coordinates, ship_length)
    if validate_human_coordinates(coordinates, ship_length).length == 0
      create_human_ship(coordinates)
    else
      validate_human_coordinates(coordinates, ship_length)
    end
  end

  def select_computer_shot(shots)
    potential_shots = @grid.keys - shots
    potential_shots[rand(potential_shots.length)]
  end

  def validate_player_shot(coordinate, shots)
    number_exists = @validation.detect_number_does_not_exist_on_board([*coordinate], columns)
    letter_exists = @validation.detect_letter_does_not_exist_on_board([*coordinate], rows)
    if shots.include?(coordinate) && !number_exists && !letter_exists
      "Coordinate already fired upon."
    else
      shots << coordinate
    end
  end

  def hit?(coordinate)
    @grid[coordinate].instance_of? Ship
  end

  def add_hit_to_ship(coordinate, ship)
    ship.hits << coordinate
  end

  def add_miss_to_grid (coordinate)
    @grid[coordinate] = "M"
  end

  

end
