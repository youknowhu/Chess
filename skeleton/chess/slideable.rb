module Slideable
  attr_reader :HORIZONTAL_DIRS, :DIAGONAL_DIRS

  def moves
    moves_arr = []
    move_dirs.each do |direction|
      moves_arr += grow_unblocked_moves_in_dir(direction)
    end
    moves_arr
  end

  private

  HORIZONTAL_DIRS = [[0, -1], [0, 1], [-1, 0], [1, 0]].freeze
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, -1], [1, 1]].freeze

  def grow_unblocked_moves_in_dir(direction)
    unblocked_moves = []
    next_pos = [pos[0] + direction[0], pos[1] + direction[1]]

    while board.valid_pos?(next_pos) && board[next_pos].is_a?(NullPiece)
      unblocked_moves << next_pos
      next_pos = [next_pos[0] + direction[0], next_pos[1] + direction[1]]
    end

    if board.valid_pos?(next_pos) &&
        !board[next_pos].is_a?(NullPiece) &&
        board[next_pos].color != color
      unblocked_moves << next_pos
    end

    unblocked_moves
  end
end
