module Stepable
  def moves
    moves_arr = []
    move_diffs.each do |direction|
      next_pos = [pos[0] + direction[0], pos[1] + direction[1]]
      if board.valid_pos?(next_pos) && board[next_pos].is_a?(NullPiece)
        moves_arr << next_pos
      elsif board.valid_pos?(next_pos) &&
        !board[next_pos].is_a?(NullPiece) &&
        board[next_pos].color != color

        moves_arr << next_pos
      end
    end

    moves_arr
  end
end
