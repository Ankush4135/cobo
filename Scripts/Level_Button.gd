extends Button

signal level_path_pressed(path) 

export(String, FILE) var Level_Scene = ""

func _on_Level_Button_pressed():
	emit_signal("level_path_pressed",Level_Scene)
