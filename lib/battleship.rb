require './lib/player'
require './lib/timer'

class Battleship

attr_reader :display

  def initialize
    @display = ""
    @response = ""
    @initial_menu = true
    @computer = Player.new
    @human = Player.new
    @begin_time = nil
  end

  def welcome_message
    @display = "Welcome to BATTLESHIP" + "\n\n" +
    "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def get_response
    @response = gets.chomp
    if @initial_menu
      response_to_welcome
    else
      game_play
    end
  end

  def response_to_welcome
    if @response == "p" || @response == "play"
      @begin_time = Timer.new
      @computer.board.place_computer_ships
      @initial_menu = false
      @display = "I have laid out my ships on the grid." + "\n" +
      "You now need to layout your two ships." + "\n" +
      "The first is two units long and the" + "\n" +
      "second is three units long." + "\n" +
      "The grid has A1 at the top left and D4 at the bottom right." + "\n\n" +
      "Enter the squares for the two-unit ship:"
    elsif @response == "i" || @response == "instructions"
      @display = "Battleship is played as computer vs. human." + "\n" +
      "Each has two ships to place on the grid." + "\n" +
      "After the ships are placed, each will take turns to fire one shot."+ "\n" +
      "The shots are recorded as hit(H) or miss(M)." + "\n" +
      "First player to sink all the other players ships wins!"
    elsif @response == "q" || @response == "quit"
      exit
    else
      welcome_message
    end
  end

  def game_play
    if @human.board.ships.count < 2
      errors = @human.board.create_valid_human_ship(@response, (@human.board.ships.count + 2))
      if errors.length != 0
        @display = errors + "\n" + "Please re-enter coordinates for two-unit ship."
      elsif @human.board.ships.count == 1
        @display = "Please enter coordinates for three-unit ship."
      end
    end
  end


end

if __FILE__ == $PROGRAM_NAME
battleship = Battleship.new
battleship.welcome_message
  loop do
    puts battleship.display
    battleship.get_response
  end
end
