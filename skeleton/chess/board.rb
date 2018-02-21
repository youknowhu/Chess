require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'null_piece'
require_relative 'pawn'
require_relative 'piece'
require_relative 'queen'
require_relative 'rook'
require 'byebug'

class Board
  attr_reader :rows

  def initialize(rows = Array.new(8) { Array.new(8) })
    @rows = rows #Array of Arrays
  end

  def fill_board
    rows.each_with_index do |row, row_index|
      row.each_index do |col_index|
        if row_index.between?(2, 5)
          rows[row_index][col_index] = NullPiece.instance
        elsif row_index == 1
          rows[row_index][col_index] = Pawn.new(:black, self, [row_index, col_index])
        elsif row_index == 6
          rows[row_index][col_index] = Pawn.new(:white, self, [row_index, col_index])
        end
      end
    end

    colors = { black: 0, white: 7 }
    (0...rows.count).each do |col|
      colors.each do |color, row|
        case col
        when 0, 7
          rows[row][col] = Rook.new(color, self, [row, col])
        when 1, 6
          rows[row][col] = Knight.new(color, self, [row, col])
        when 2, 5
          rows[row][col] = Bishop.new(color, self, [row, col])
        when 3
          rows[row][col] = Queen.new(color, self, [row, col])
        when 4
          rows[row][col] = King.new(color, self, [row, col])
        end
      end
    end
  end

  def [](pos)
    x, y = pos
    rows[x][y]
  end

  def []=(pos, val)
    x, y = pos
    rows[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    raise "No piece at start position" if self[start_pos].is_a?(NullPiece)
    if self[start_pos].valid_moves.include?(end_pos)
      raise "Piece cannot move to end position"
    end
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0,7) }
  end

  # def add_piece(piece, pos)
  # end


  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |piece| piece.color == color }.all? do |p|
      p.valid_moves.empty?
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def find_king(color)
    pieces.each do |piece|
      return piece.pos if piece.is_a?(King) && piece.color == color
    end
  end

  def pieces
    rows.flatten.reject { |piece| piece.is_a?(NullPiece) }
  end

  def dup
    duped_board = Board.new(rows.deep_dup)
    duped_board.pieces.each { |piece| piece.board = duped_board }
    duped_board
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
  end
end

class Array
  def deep_dup
    self.map do |el|
      if el.is_a?(Array)
        el.deep_dup
      elsif !el.is_a?(NullPiece)
        el.dup
      else
        el
      end
    end
  end
end
