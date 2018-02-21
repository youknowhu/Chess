require_relative 'board'
require_relative 'display'
require_relative 'player'
require 'byebug'

class Chess
  attr_reader :board, :display, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = [Player.new(:white, display), Player.new(:black, display)]
  end

  def play
    board.fill_board

    until board.checkmate?(players[0].color)
      # system('clear')
      notify_players
      display.render

      start_pos, end_pos = nil, nil
      until display.cursor.selected && start_pos
        # system('clear')
        notify_players
        display.render
        start_pos = display.cursor.get_input
        if start_pos && display.cursor.selected
          piece = display.cursor.selected
          if piece.color != players[0].color
            display.cursor.toggle_selected
            start_pos = nil
          end
        end
      end

      moves = piece.valid_moves

      while display.cursor.selected
        # system('clear')
        notify_players
        display.render
        end_pos = display.cursor.get_input
      end

      if moves.include?(end_pos)
        board.move_piece!(start_pos, end_pos)
        swap_turn!
        start_pos = nil
      else
        end_pos = nil
      end
    end
    puts "#{players[1].color} wins!"
  end

  private

  def notify_players
    puts "#{players[0].color}'s turn!\n"
  end

  def swap_turn!
    players.rotate!
  end
end

if $PROGRAM_NAME == __FILE__
  Chess.new.play
end
