extends TouchScreenButton



func _ready():
	var size = get_parent().rect_size
	self.set_scale(size)
	
