extends Control

var reload = ""

func _ready():
	reload = PlayerData.restart_level
	yield(get_tree().create_timer(.1), "timeout")
	get_tree().change_scene(reload)
