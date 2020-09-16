extends Control

signal Play_Level_Path(path) 

export(bool) var Disable = false
export(String) var Level = ""
export(int, "Normal", "Dark", "Onetouch") var Level_Mode
export (Texture) var Star
export (Texture) var Star_empty

onready var timer = $Timer
var Level_Scene = ""
var timeouted = false
var star_value

func _ready():
	if LevelManager.level_info.has(int(Level)):
		Disable = LevelManager.level_info[int(Level)]["disabled"]
		
		if LevelManager.level_info[int(Level)]["stars unlocked"] == 1:
			$Level_Button/Stars/Star1.texture = Star
		if LevelManager.level_info[int(Level)]["stars unlocked"] == 2:
			$Level_Button/Stars/Star1.texture = Star
			$Level_Button/Stars/Star2.texture = Star
		if LevelManager.level_info[int(Level)]["stars unlocked"] == 3:
			$Level_Button/Stars/Star1.texture = Star
			$Level_Button/Stars/Star2.texture = Star
			$Level_Button/Stars/Star3.texture = Star
		else:
			pass
	else:
		Disable = false
	$Level_Button.text = Level
	$Level_Button.disabled = Disable
	$Level_Button/Stars.visible = not Disable
	Level_Scene = "res://Scenes/Levels/Level_" + Level + ".tscn"
		

func _on_Level_Button_pressed():
	if timeouted == true:
		timeouted = false
		return
	else:
		Audio.Select.play()
		LevelManager.level_mode = Level_Mode
		emit_signal("Play_Level_Path",Level_Scene)

func _on_Timer_timeout():
	timeouted = true

func _on_Level_Button_button_down():
	timer.wait_time = .3
	timer.start()
