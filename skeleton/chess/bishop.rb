require_relative 'slideable'
require_relative 'piece'
class Bishop < Piece
  include Slideable

  def symbol
    :bishop
  end

  protected
  def move_dirs
    DIAGONAL_DIRS
  end
end
