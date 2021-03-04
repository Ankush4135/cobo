extends Node

signal scene_changed(path) 

onready var loading_scene = $LoadingScreen
onready var animation = $Scene_trans/AnimationPlayer
onready var colorec = $Scene_trans/ColorRect

export(String, FILE) var Change_Scene = ""

func _ready():
	PlayerData.total_score = PlayerData.player_info[1]["total score"]
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	$Menu/Buttons_Lists/Play.grab_focus()
	Audio.BG.play()

func _on_Button_pressed():
	emit_signal("scene_changed", Change_Scene)
	Audio.Select.play()
	loading_scene.visible = true



	
