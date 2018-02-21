class Player
  attr_reader :color
  def initialize(color, display)
    @color = color
    @display = display
  end
end

class HumanPlayer < Player
  def make_move(_board)

  end
end

class ComputerPlayer < Player
  def make_move(board)

  end
end
