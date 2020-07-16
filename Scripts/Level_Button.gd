extends Button

signal change_scene_to_level(path) 

export(String, FILE) var Level_Scene = ""

func _on_Level_Button_pressed():
	emit_signal("change_scene_to_level",Level_Scene)
