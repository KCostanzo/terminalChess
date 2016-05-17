require_relative 'piece'

class Pawn < Piece

  def symbol
    '♟'.colorize(color)
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def start_row?
    pos[0] == ((color == :white) ? 6 : 1)
  end

  def pawn_dir
    (color == :white) ? -1 : 1
  end

  def forward_steps
    i, j = pos
    one_step = [i + pawn_dir, j]
    return [] unless board.valid_pos?(one_step) && board.empty?(one_step)

    steps = [one_step]
    two_step = [i + 2 * pawn_dir, j]
    steps << two_step if start_row? && board.empty?(two_step)
    steps
  end

  def side_attacks
    i, j = pos

    side_moves = [[i + pawn_dir, j - 1], [i + pawn_dir, j + 1]]

    side_moves.select do |new_pos|
      next false unless board.valid_pos?(new_pos)
      next false if board.empty?(new_pos)

      threatened_piece = board[new_pos]
      threatened_piece && threatened_piece.color != color
    end
  end
end
