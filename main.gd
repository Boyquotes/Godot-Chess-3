extends Node2D

onready var board_tilemap = get_node("board")
onready var pieces_tilemap = get_node("pieces")
onready var cursor_sprite = get_node("cursorSprite")

#this is super hacky, but basically since a theme has 4 tiles, we can render the board using 
#this enum as a sort of "offset" to add our way into the correct theme
enum board_theme {BW = 0, TAN = 4}
var current_theme

enum piece_type {None, Pawn, Knight, Bishop, Rook, Queen, King}
enum piece_color {White = 8, Black = 16}

var moving = false
var selected_square
var moving_piece

var current_turn #0 = white, 1 = black


var board = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	current_theme = board_theme.TAN
	board_tilemap.setup_theme(current_theme)
	board_tilemap.draw_board()
	board.resize(64)
	setup_pieces()
	pieces_tilemap.draw_pieces(board)
	current_turn = 0

func _input(event):
	if event.is_action_released("mouse_left"):
		var mouse_pos = get_global_mouse_position()
		var clicked_tile_pos = board_tilemap.world_to_map(mouse_pos)
		var clicked_tile_index = (clicked_tile_pos.y  * 8) + clicked_tile_pos.x
		if board[clicked_tile_index] != null and !moving and get_piece_color(clicked_tile_index) == current_turn:
			select_piece(clicked_tile_pos, board[clicked_tile_index], clicked_tile_index)
		elif moving:
			place_piece(clicked_tile_pos, moving_piece, clicked_tile_index)
		
func select_piece(square, piece, index):
	selected_square = square
	moving = true
	cursor_sprite.setCursor(piece)
	cursor_sprite.visible = true
	moving_piece = board[index]
	board[index] = null
	pieces_tilemap.draw_pieces(board)
	var board_clicked_tile_id = board_tilemap.get_cellv(square)
	board_clicked_tile_id -= current_theme #get the non-offset version of this tile's theme
	match board_clicked_tile_id:
		0: #light
			board_tilemap.set_cellv(square, board_tilemap.LIGHT_TILE_H)
		1: #dark
			board_tilemap.set_cellv(square, board_tilemap.DARK_TILE_H)
			
func place_piece(square, piece, index):
	if board[index] == null or current_turn != get_piece_color(index): #if the target square is empty, or the opponent's piece
		moving = false
		cursor_sprite.visible = false
		#deselect highlighted square
		var board_selected_tile_id = board_tilemap.get_cellv(selected_square)
		board_selected_tile_id -= current_theme #get the non-offset version of this tile's theme
		match board_selected_tile_id:
			2: #light
				board_tilemap.set_cellv(selected_square, board_tilemap.LIGHT_TILE)
			3: #dark
				board_tilemap.set_cellv(selected_square, board_tilemap.DARK_TILE)
		board[index] = piece
		pieces_tilemap.draw_pieces(board)
		#cycle the turns. no ternary operator in gdscript makes me sad
		if current_turn == 0:
			current_turn = 1
		else:
			current_turn = 0

func get_piece_color(index):
	if (board[index] == null):
		return null
	elif (board[index] >= 9 and board[index] <= 14): #white
		return 0
	else: #black
		return 1

func setup_pieces():
	#this feels clunky but I can't think of a better way to do it at the moment
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
