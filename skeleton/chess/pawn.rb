require_relative 'piece'
class Pawn < Piece
  attr_reader :direction

  def symbol
    :pawn
  end

  def moves
    forward_steps + side_attacks
  end


  def move_dirs
    case color
    when :white
      [-1, 0]
    when :black
      [1, 0]
    end
  end

  # private
  def at_start_row?
    if color == :white && pos[0] == 6 || color == :black && pos[0] == 1
      true
    else
      false
    end
  end

  def forward_dir
    move_dirs[0]
  end

  def forward_steps
    steps = []
    if at_start_row?
      steps << [pos[0] + move_dirs[0] * 2 , pos[1]]
    end
    steps << [pos[0] + move_dirs[0], pos[1]]

    steps.select do |step|
      board.valid_pos?(step) && board[step].is_a?(NullPiece)
    end
  end

  def side_attacks
    attack_positions = [[pos[0] + move_dirs[0], pos[1] + 1],
                        [pos[0] + move_dirs[0], pos[1] - 1]]

    attack_positions.select do |pos|
      board.valid_pos?(pos) &&
        !board[pos].is_a?(NullPiece) &&
        board[pos].color != color
    end
  end
end
