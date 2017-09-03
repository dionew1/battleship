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
    @validation = Validation.new(@rows, @columns)
  end

end
