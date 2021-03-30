extends Node

#q offsets also get used by the king
enum q_slide_offsets {U = -10, UR = -9, R = 1, DR = 11, D = 10, DL = 9, L = -1, UL = -11}
enum r_slide_offsets {U = -10, R = 1, D = 10, L = -1}
enum b_slide_offsets {UR = -9, DR = 11, DL = 9, UL = -11}
#i couldn't think of "names" for these but it doesn't really matter i suppose
#they were determined by considering a knight's possible jumps clockwise from "top right", if that makes sense
enum n_jump_offsets {a = -21, b = -19, c = -8, d = 12, e = 21, f = 19, g = 8, h = -12} 
enum wp_capture_offsets{a = -9, b = -11}
enum bp_capture_offsets{a = 9, b = 11}

func generate_queen_moves(board, index):
	#print ("Generating queen moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	for dir in q_slide_offsets:
		next_pos = index + q_slide_offsets[dir]
		#as long as we don't run into an unreachable square, or an allied piece
		while board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
			#if we've found a capture, we can stop looking for more moves in this direction
			if (get_piece_color(board, next_pos) != color) and (get_piece_color(board, next_pos) != null): 
				break
			next_pos += q_slide_offsets[dir]
	return final_moves

func generate_rook_moves(board, index):
	#print ("Generating rook moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	for dir in r_slide_offsets:
		next_pos = index + r_slide_offsets[dir]
		#as long as we don't run into an unreachable square, or an allied piece
		while board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
			#if we've found a capture, we can stop looking for more moves in this direction
			if (get_piece_color(board, next_pos) != color) and (get_piece_color(board, next_pos) != null): 
				break
			next_pos += r_slide_offsets[dir]
	return final_moves

func generate_bishop_moves(board, index):
	#print ("Generating bishop moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	for dir in b_slide_offsets:
		next_pos = index + b_slide_offsets[dir]
		#as long as we don't run into an unreachable square, or an allied piece
		while board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
			#if we've found a capture, we can stop looking for more moves in this direction
			if (get_piece_color(board, next_pos) != color) and (get_piece_color(board, next_pos) != null): 
				break
			next_pos += b_slide_offsets[dir]
	return final_moves

func generate_knight_moves(board, index):
	#print ("Generating knight moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	for dir in n_jump_offsets:
		next_pos = index + n_jump_offsets[dir]
		#as long as we don't run into an unreachable square, or an allied piece
		if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
	return final_moves

func generate_king_moves(board, index):
	#print ("Generating king moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	for dir in q_slide_offsets:
		next_pos = index + q_slide_offsets[dir]
		#as long as we don't run into an unreachable square, or an allied piece
		#basic king moves are calculated identically to the queen, except we use an if instead of a while
		if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
	return final_moves

#the logic for pawns is a little ugly, it may have to be changed to allow for enpassant and stuff
func generate_pawn_moves(board, index):
	#print ("Generating pawn moves!")
	var final_moves = Array()
	var next_pos
	var color = get_piece_color(board, index)
	final_moves.append(index)
	if color == 0: #white pawn
		next_pos = index - 10
		if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
		if (floor(index / 10) == 8):
			next_pos -= 10
			if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
				final_moves.append(next_pos)
		for dir in wp_capture_offsets:
			next_pos = index + wp_capture_offsets[dir]
			if (get_piece_color(board, next_pos) != color) and (get_piece_color(board, next_pos) != null): 
				final_moves.append(next_pos)
		
	if color == 1: #black pawn
		next_pos = index + 10
		if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
			final_moves.append(next_pos)
		if (floor(index / 10) == 3):
			next_pos += 10
			if board[next_pos] != -1 and color != get_piece_color(board, next_pos):
				final_moves.append(next_pos)
		for dir in bp_capture_offsets:
			next_pos = index + bp_capture_offsets[dir]
			if (get_piece_color(board, next_pos) != color) and (get_piece_color(board, next_pos) != null): 
				final_moves.append(next_pos)
	
	return final_moves


#find the color of the piece in board[] at a given index
func get_piece_color(board, index):
	if (board[index] == null):
		return null
	elif (board[index] >= 9 and board[index] <= 14): #white
		return 0
	else: #black
		return 1
