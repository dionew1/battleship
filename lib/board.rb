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
  end

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

  def detect_horizontal_wrap(split_coordinates)
    numbers = get_numbers(split_coordinates)
    numbers.include?("1") && numbers.include?(@columns.length.to_s)
  end

  def detect_vertical_wrap(split_coordinates)
    letters = get_letters(split_coordinates)
    letters.include?("A") && letters.include?(@rows.last)
  end

end
