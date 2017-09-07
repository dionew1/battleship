require './lib/player'
require './lib/timer'

class Battleship

attr_reader :display

  def initialize
    @display = ""
    @response = ""
    @initial_menu = true
    @human_set_up = true
    @battle = true
    @computer = Player.new
    @human = Player.new
    @begin_time = nil
    @human_turn = true
  end

  def welcome_message
    @display = "Welcome to BATTLESHIP" + "\n\n" +
    "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def get_response
    @response = gets.chomp
    if @initial_menu
      response_to_welcome
    elsif @human_set_up
      human_ship_placement
    elsif @battle
      battle_ships
    else
      end_game
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

  def build_human_ship_placement_display(errors)
    if errors.length != 0
      @display = errors + "\n" + "Please re-enter coordinates for two-unit ship."
    elsif @human.board.ships.count == 1
      @display = "Please enter coordinates for three-unit ship."
    elsif @human.board.ships.count == 2
      @human.board.assign_ships_to_grid
      @display = @computer.board.display_grid + "\n" + "Enter coordinates to fire:"
      @human_set_up = false
    end
  end

  def human_ship_placement
    if @human.board.ships.count < 2
      errors = @human.board.create_valid_human_ship(@response, (@human.board.ships.count + 2))
      build_human_ship_placement_display(errors)
    end
  end

  def end_human_turn(shots_taken)
    if shots_taken != @human.shots.length
      @display += "\n" + "Press enter to end turn:"
      @human_turn = false
    end
  end

  def shot_turns
    if @human_turn
      shots_taken = @human.shots.length
      @display = "\n" + @computer.board.fire_human_shot(@response, @human.shots)+ "\n\n" +
      @computer.board.display_grid
      end_human_turn(shots_taken)
    else
      results = @human.board.fire_computer_shot(@computer.shots)
      @display = @human.board.display_grid + "\n\n\n" + results
      @human_turn = true
      @display += "\n\n" + @computer.board.display_grid
      @display += "\n\n Enter coordinates to fire:"
    end
  end

  def battle_ships
    @response = @response.upcase
    if !@computer.board.sunk_all? && !@human.board.sunk_all?
      shot_turns
    else
      @battle = false
    end
  end

  def reset_game
    @response = ""
    @initial_menu = true
    @human_set_up = true
    @battle = true
    @computer = Player.new
    @human = Player.new
    @begin_time = nil
    @human_turn = true
  end

  def end_game
    if @human.board.sunk_all?
      @display = "Sorry, you lost."
      @display += "\n" + "The winner fired #{@computer.shots.count.to_s} total shots!"
    else
      @display = "Congratulations! You sunk the ships!"
      @display += "\n" + "The winner fired #{@human.shots.count.to_s} total shots!"
    end
    @display += "\n" + @begin_time.time_of_game
    reset_game
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
