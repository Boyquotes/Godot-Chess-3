extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	self.set_frame(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()
	

#take the value from board[index], and match it to the frame that represents that piece
func setCursor(x):
	match x:
		0:
			return
		9: #wP
			self.set_frame(0)
			return
		10: #wN
			self.set_frame(1)
			return
		11: #wB
			self.set_frame(2)
			return
		12: #wR
			self.set_frame(3)
			return
		13: #wQ
			self.set_frame(4)
			return
		14: #wK
			self.set_frame(5)
			return
		17: #bP
			self.set_frame(6)
			return
		18: #bN
			self.set_frame(7)
			return
		19: #bB
			self.set_frame(8)
			return
		20: #bR
			self.set_frame(9)
			return
		21: #bQ
			self.set_frame(10)
			return
		22: #bK
			self.set_frame(11)
			return
		_:
			return null
