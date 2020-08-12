extends Control

signal Play_Level_Path(path) 

export(bool) var Disable = false
export(String) var Level = ""
export(int, "Normal", "Dark", "Onetouch") var Level_Mode
export (bool) var score_goal_met

var Level_Scene = ""

func _ready():
	if LevelManager.level_info.has(int(Level)):
		Disable = LevelManager.level_info[int(Level)]["disabled"]
		if LevelManager.level_info[int(Level)]["stars unlocked"] == 1:
			score_goal_met = true
		else:
			score_goal_met = false
	else:
		Disable = false
	$Level_Button.text = Level
	$Level_Button.disabled = Disable
	Level_Scene = "res://Scenes/Levels/Level_" + Level + ".tscn"


func _on_Level_Button_pressed():
	Audio.Select.play()
	LevelManager.level_mode = Level_Mode
	emit_signal("Play_Level_Path",Level_Scene)
