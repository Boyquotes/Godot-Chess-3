extends TileMap



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func draw_pieces(board_array):
	for i in board_array.size():
		var current_file = i % 8
		var current_rank = (i - current_file) / 8
		var piece_tile = get_piece(board_array[i])
		if(piece_tile != null):
			self.set_cell(current_file, current_rank, piece_tile)
		else:
			self.set_cell(current_file, current_rank, -1)
		
		
	
	

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
