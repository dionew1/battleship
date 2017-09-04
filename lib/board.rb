class Board

attr_reader :grid, :rows, :columns, :ships

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

end
