require_relative 'slideable'
require_relative 'piece'

class Queen < Piece
  include Slideable

  def symbol
    :queen
  end

  protected
  def move_dirs
    HORIZONTAL_DIRS + DIAGONAL_DIRS
  end
end
