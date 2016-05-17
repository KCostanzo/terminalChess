require_relative 'board'
require_relative 'my_player'

class Game
  attr_reader :board, :display, :current_player, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: MyPlayer.new(:white, @display),
      black: MyPlayer.new(:black, @display)
    }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      begin
        from_pos, to_pos = players[current_player].make_move(board)
        board.move(current_player, from_pos, to_pos)

        switch_players!
        update_status
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end

    display.render
    puts "#{current_player} checkmated!"
    nil
  end

  private

  def update_status
    if board.in_check?(current_player)
      display.set_check!
    else
      display.uncheck!
    end
  end

  def switch_players!
    @current_player = (current_player == :white) ? :black : :white
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
