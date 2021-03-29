extends Node2D

onready var board = get_node("board")

#this is super hacky, but basically since a theme has 4 tiles, we can render the board using 
#this enum as a sort of "offset" to add our way into the correct theme
enum board_theme {BW = 0, TAN = 4}

# Called when the node enters the scene tree for the first time.
func _ready():
	board.setup_theme(board_theme.TAN)
	board.draw_board()
	pass # Replace with function body.


