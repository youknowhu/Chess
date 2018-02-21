require_relative 'stepable'
require_relative 'piece'


class Knight < Piece
  include Stepable

  def symbol
    :knight
  end

  protected

  def move_diffs
    [[1, 2],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [2, 1],
     [2, -1],
     [-2, 1],
     [-2, -1]]
  end
end
