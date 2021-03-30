extends TileMap

#iterate through the board array, and if there's a piece there, display it. otherwise display nothing
func draw_pieces(board_array):
	for i in range(21, 99):
		if !(i % 10 == 0 || i % 10 == 9):
			var piece_coords = index_to_coords(i)
			if (board_array[i] != null): #if the square isn't empty
				var piece_tile = get_piece(board_array[i])
				#var debug_string = "Placing piece from index %s at coords %s, %s"
				#print(debug_string % [i, piece_coords.x, piece_coords.y])
				self.set_cellv(piece_coords, piece_tile)
			else:
				self.set_cellv(piece_coords, -1)
		
		
#get the appropriate tile number from the board[num] value
func get_piece(num):
	match num:
		0:
			return null
		9: #wP
			return 0
		10: #wN
			return 1
		11: #wB
			return 2
		12: #wR
			return 3
		13: #wQ
			return 4
		14: #wK
			return 5
		17: #bP
			return 6
		18: #bN
			return 7
		19: #bB
			return 8
		20: #bR
			return 9
		21: #bQ
			return 10
		22: #bK
			return 11
		_:
			return null

#helper function takes index in board[] and returns a Vector2 of its coordinates on the tilemaps
func index_to_coords(index):
	var current_file = (index % 10) - 1
	var current_rank = ((index - current_file)/10) - 2
	return Vector2(current_file, current_rank)

