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
		
		
	
	

func get_piece(num):
	match num:
		0:
			return null
		9: #wP
			return 0
		10:
			return 1
		11:
			return 2
		12:
			return 3
		13:
			return 4
		14:
			return 5
		17:
			return 6
		18:
			return 7
		19:
			return 8
		20:
			return 9
		21: 
			return 10
		22:
			return 11
		_:
			return null
