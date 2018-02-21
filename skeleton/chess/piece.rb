class Piece
  attr_accessor :board
  attr_reader :pos, :color

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol.to_s
  end

  def empty?
  end

  def valid_moves
    valid_moves = moves.reject do |move|
      move_into_check?(move)
    end

    valid_moves
  end

  def pos=(val)
    @pos = val
  end

  def symbol
    :symbol
  end

  def inspect
    "Symbol: #{symbol} Color: #{color} Board: #{board}"
  end

  private

  def move_into_check?(end_pos)
    duped_board = board.dup
    duped_board[pos] = NullPiece.instance
    duped_board[end_pos] = self
    duped_board.in_check?(color)
  end
end
