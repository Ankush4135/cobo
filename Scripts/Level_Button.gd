tool
extends Control

signal Play_Level_Path(path) 

export(bool) var Disable = false
export(String) var Level = ""
export(int, "Normal", "Dark", "Onetouch") var Level_Mode

var Level_Scene = ""

func _ready():
	$Level_Button.text = Level
	$Level_Button.disabled = Disable
	Level_Scene = "res://Scenes/Levels/Level_" + Level + ".tscn"

func _on_Level_Button_pressed():
	Audio.Select.play()
	LevelManager.level_mode = Level_Mode
	emit_signal("Play_Level_Path",Level_Scene)
