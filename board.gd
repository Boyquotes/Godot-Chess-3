extends TileMap

var LIGHT_TILE
var DARK_TILE
var LIGHT_TILE_H
var DARK_TILE_H

#this is super hacky, but basically since a theme has 4 tiles, we can render the board using 
#this enum as a sort of "offset" to add our way into the correct theme
enum board_theme {BW = 0, TAN = 4}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
		

func setup_theme(theme):
	var theme_offset = board_theme.theme
	LIGHT_TILE = 0 + theme_offset
	DARK_TILE = 1 + theme_offset
	LIGHT_TILE_H = 2 + theme_offset
	DARK_TILE_H = 3 + theme_offset


func draw_board():
	for file in 8:
		for rank in 8:
			if (file + rank) % 2 == 0: #if light tile
				self.set_cell(file, rank, LIGHT_TILE)
			else: #dark tile
				self.set_cell(file, rank, DARK_TILE)
