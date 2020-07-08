extends TouchScreenButton



func _process(delta):
	var size = get_parent().rect_size
	self.set_scale(size)
	
