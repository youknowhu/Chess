require_relative 'cursor'
require_relative 'board'
require 'colorize'
require 'byebug'

UNICODE_HASH = {
  king: "\u265A",
  queen: "\u265B",
  rook: "\u265C",
  bishop: "\u265D",
  knight: "\u265E",
  pawn: "\u265F",
  null_piece: " "
}

class Display
  attr_reader :cursor, :board


  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    ("A".."H").each { |el| print "  #{el}".center(4) }
    print "\n"
    board.rows.each_with_index do |row, row_index|
      print 8 - row_index
      row.each_index do |col_index|
        piece = board[[row_index, col_index]]
        unicode = UNICODE_HASH[piece.symbol]
        if [row_index, col_index] == cursor.cursor_pos
          if cursor.selected
            print unicode.center(4).colorize(:color => piece.color,:background => :blue)
          else
            print unicode.center(4).colorize(:color => piece.color,:background => :red)
          end
        elsif (row_index + col_index).even?
          print unicode.center(4).colorize(:color => piece.color,:background => :light_white)
        else
          print unicode.center(4).colorize(:color => piece.color,:background => :light_black)
        end
      end
      print "\n"
    end
  end
end
