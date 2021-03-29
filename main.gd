extends Node2D

onready var board_tilemap = get_node("board")
onready var pieces_tilemap = get_node("pieces")

#this is super hacky, but basically since a theme has 4 tiles, we can render the board using 
#this enum as a sort of "offset" to add our way into the correct theme
enum board_theme {BW = 0, TAN = 4}


enum piece_type {None, Pawn, Knight, Bishop, Rook, Queen, King}
enum piece_color {White = 8, Black = 16}

#class Piece:
#	var type
#	var color
	
var board = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	board_tilemap.setup_theme(board_theme.TAN)
	board_tilemap.draw_board()
	board.resize(64)
	setup_pieces()
	pieces_tilemap.draw_pieces(board)
	pass # Replace with function body.

func setup_pieces():
	#black pieces
	board[0] = piece_type.Rook | piece_color.Black
	board[1] = piece_type.Knight | piece_color.Black
	board[2] = piece_type.Bishop | piece_color.Black
	board[3] = piece_type.Queen | piece_color.Black
	board[4] = piece_type.King | piece_color.Black
	board[5] = piece_type.Bishop | piece_color.Black
	board[6] = piece_type.Knight | piece_color.Black
	board[7] = piece_type.Rook | piece_color.Black
	for i in range (8,16):
		board[i] = piece_type.Pawn | piece_color.Black
	#white pieces
	board[56] = piece_type.Rook | piece_color.White
	board[57] = piece_type.Knight | piece_color.White
	board[58] = piece_type.Bishop | piece_color.White
	board[59] = piece_type.Queen | piece_color.White
	board[60] = piece_type.King | piece_color.White
	board[61] = piece_type.Bishop | piece_color.White
	board[62] = piece_type.Knight | piece_color.White
	board[63] = piece_type.Rook | piece_color.White
	for i in range (48,56):
		board[i] = piece_type.Pawn | piece_color.White
