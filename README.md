#Chess

A 2-player in-terminal chess game built in Ruby

###Instructions

Download zip, unzip, and open in terminal with:

```
ruby game.rb
```

WASD or Arrow keys to move cursor, spacebar or enter to select piece/desired move

###Implementation Details

OOP heavy design with the majority of functions in the board class. Display holds the board which is altered by the game.run method which should run until the game reaches its end condidtion (checkmate).

```ruby
	until board.checkmate?(current_player)
	  begin
	    from_pos, to_pos = players[current_player].make_move(board)
	    board.move_piece(current_player, from_pos, to_pos)

	    switch_players!
	    update_status
	  rescue StandardError => e
	    @display.notifications[:error] = e.message
	    retry
	  end
	end
```

The logic for the piece's availible moves is in the piece itself (pawn) or one of its modules that details the specific moves availible to its inheriting classes. In addition pieces check their possible moves against moving into check by using a duplicated board to avoid board contamination. This is seen in the following piece (superclass) method: 

```ruby
	def valid_moves
		moves.reject { |to_pos| move_into_check?(to_pos) }
	end

  	private

	def move_into_check?(to_pos)
    	test_board = board.board_dup
    	test_board.move_piece!(pos, to_pos)
    	test_board.in_check?(color)
	end
```

###Todos

- [ ] AI