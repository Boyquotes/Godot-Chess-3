extends Node2D

onready var board_tilemap = get_node("board")
onready var pieces_tilemap = get_node("pieces")
onready var cursor_sprite = get_node("cursorSprite")

#this is super hacky, but basically since a theme has 4 tiles, we can render the board using 
#this enum as a sort of "offset" to add our way into the correct theme
enum board_theme {BW = 0, TAN = 4}
var current_theme

#idea borrowed from Sebastian Lague on YouTube: https://youtu.be/U4ogK0MIzqk
#pieces are represented in such a way that if examined in binary, first two digits indicate color
#and last 3 indicate piece type. e.g. white pawn = 9 = 01001, black rook = 20 = 10100
enum piece_type {None, Pawn, Knight, Bishop, Rook, Queen, King}
enum piece_color {White = 8, Black = 16}

var moving = false #is a piece currently being "held"?
var selected_square #currently highilighted square
var moving_piece #type of piece currently being moved
var legal_moves #list of legal destinations for the currently moving piece

var current_turn #0 = white, 1 = black


var board = Array() #master representation of the board. array of ints, size=64

# Called when the node enters the scene tree for the first time.
func _ready():
	current_theme = board_theme.TAN #this will be a user option eventually
	board_tilemap.setup_theme(current_theme)
	board_tilemap.draw_board()
	init_board_array()
	setup_pieces()
	pieces_tilemap.draw_pieces(board)
	current_turn = 0

func _input(event):
	if event.is_action_released("mouse_left"):
		var mouse_pos = get_global_mouse_position()
		var clicked_tile_pos = board_tilemap.world_to_map(mouse_pos) #grab the tile in the tilemap
		var clicked_tile_index = coords_to_index(clicked_tile_pos) #calculate the corresponding index in board[]
		#if there's a piece in the square we clicked, we aren't already moving one, and the piece belongs to the current player
		if board[clicked_tile_index] != null and !moving and get_piece_color(clicked_tile_index) == current_turn:
			select_piece(clicked_tile_pos, board[clicked_tile_index], clicked_tile_index)
		#if we're moving a piece, we can try and place it on the new square
		elif moving:
			place_piece(moving_piece, clicked_tile_index)
		
func select_piece(square, piece, index):
	selected_square = square #important later for removing the highlight effect
	moving = true
	cursor_sprite.setCursor(piece) #set the cursor sprite to the piece we're moving, and make it visible
	cursor_sprite.visible = true
	moving_piece = board[index] #also important later, for putting the piece back down
	board[index] = null #remove the piece from the board
	pieces_tilemap.draw_pieces(board)
	var board_clicked_tile_id = board_tilemap.get_cellv(square)
	board_clicked_tile_id -= current_theme #get the non-offset version of this tile's theme
	match board_clicked_tile_id:
		0: #light
			board_tilemap.set_cellv(square, board_tilemap.LIGHT_TILE_H)
		1: #dark
			board_tilemap.set_cellv(square, board_tilemap.DARK_TILE_H)
			
func place_piece(piece, index):
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
		if (!(coords_to_index(selected_square) == index)): #if the player didnt put the piece back where it started
			if current_turn == 0:#cycle the turns. no ternary operator in gdscript makes me sad
				current_turn = 1
			else:
				current_turn = 0

#find the color of the piece in board[] at a given index
func get_piece_color(index):
	if (board[index] == null):
		return null
	elif (board[index] >= 9 and board[index] <= 14): #white
		return 0
	else: #black
		return 1

#helper function takes index in board[] and returns a Vector2 of its coordinates on the tilemaps
func index_to_coords(index):
	var current_file = (index % 10) - 1
	var current_rank = ((index - current_file)/10) - 2
	return Vector2(current_file, current_rank)

#helper function takes a Vector2 of tilemap coordinates and returns the corresponding index in board[]
func coords_to_index(coords):
	var ten_digit = (coords.y + 2)
	var one_digit = coords.x + 1
	return (ten_digit * 10) + one_digit
	
#board uses 10x12 representation as detailed here: https://www.chessprogramming.org/10x12_Board
#this function sets the off-limits squares to -1, and the playable squares to null
func init_board_array():
	board.resize(120)
	#these for loops are clunky, but easy to understand and only run once
	for i in 120:
		board[i] = -1
	for j in range(21,99): #if the top-left square is 0, then the playable 8x8 board is squares 21-98 
		board[j] = null
	

func setup_pieces():
	#this feels clunky but I can't think of a better way to do it at the moment
	#black pieces
	board[21] = piece_type.Rook | piece_color.Black
	board[22] = piece_type.Knight | piece_color.Black
	board[23] = piece_type.Bishop | piece_color.Black
	board[24] = piece_type.Queen | piece_color.Black
	board[25] = piece_type.King | piece_color.Black
	board[26] = piece_type.Bishop | piece_color.Black
	board[27] = piece_type.Knight | piece_color.Black
	board[28] = piece_type.Rook | piece_color.Black
	for i in range (31,39):
		board[i] = piece_type.Pawn | piece_color.Black
	#white pieces
	board[91] = piece_type.Rook | piece_color.White
	board[92] = piece_type.Knight | piece_color.White
	board[93] = piece_type.Bishop | piece_color.White
	board[94] = piece_type.Queen | piece_color.White
	board[95] = piece_type.King | piece_color.White
	board[96] = piece_type.Bishop | piece_color.White
	board[97] = piece_type.Knight | piece_color.White
	board[98] = piece_type.Rook | piece_color.White
	for i in range (81,89):
		board[i] = piece_type.Pawn | piece_color.White
