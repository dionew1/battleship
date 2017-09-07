require './lib/board'

class Player

  attr_reader :board
  attr_accessor :shots

  def initialize
    @shots = []
    @board = Board.new
  end

end
