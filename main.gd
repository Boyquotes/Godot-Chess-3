extends Node2D

onready var board = get_node("board")
enum board_theme {BW = 0, TAN = 4}

# Called when the node enters the scene tree for the first time.
func _ready():
	board.setup_theme(board_theme.BW)
	board.draw_board()
	pass # Replace with function body.


