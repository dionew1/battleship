class Timer

  def initialize
    @begin_time = Time.now
  end

  def time_of_game
    total_time = Time.now - @begin_time
    "This game was played in #{total_time.ceil.to_s} seconds."
  end

end
