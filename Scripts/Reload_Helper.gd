extends Control

signal reload_scene(path) 

var reload = ""

func _ready():
	reload = LevelManager.restart_level
	yield(get_tree().create_timer(.1), "timeout")
	get_tree().change_scene(reload)
	
	
	emit_signal("reload_scene", reload)
