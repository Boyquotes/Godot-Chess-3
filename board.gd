extends TileMap

var LIGHT_TILE
var DARK_TILE
var LIGHT_TILE_H
var DARK_TILE_H

#figure out the 4 tiles by using the theme offset
func setup_theme(theme):
	var theme_offset = theme
	LIGHT_TILE = 0 + theme_offset
	DARK_TILE = 1 + theme_offset
	LIGHT_TILE_H = 2 + theme_offset
	DARK_TILE_H = 3 + theme_offset

#should only get called on startup, uses established tiles to fill in the board
func draw_board():
	for file in 8:
		for rank in 8:
			if (file + rank) % 2 == 0: #if light tile
				self.set_cell(file, rank, LIGHT_TILE)
			else: #dark tile
				self.set_cell(file, rank, DARK_TILE)
