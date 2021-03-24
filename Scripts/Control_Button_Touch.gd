extends Control

func _ready():
	var current_window_size
	var scale_value
	current_window_size = OS.get_window_size().y
	scale_value = current_window_size / 1080
	self.rect_scale.x = scale_value
	self.rect_scale.y = scale_value
