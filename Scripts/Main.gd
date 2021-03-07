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
	$quit_popup.visible = false
	Audio.BG.play()

func _on_Button_pressed():
	emit_signal("scene_changed", Change_Scene)
	Audio.Select.play()
	loading_scene.visible = true


func _on_Quit_button_up():
	Audio.Select.play()
	$quit_popup/Panel/quit_cancel.grab_focus()
	$quit_popup.visible = true

func _on_quit_cancel_pressed():
	Audio.Select.play()
	$Menu/Buttons_Lists/Play.grab_focus()
	$quit_popup.visible = false

func _on_quit_ok_button_up():
	get_tree().quit()

func _on_Options_pressed():
	Audio.Select.play()
	$Settings/confirm_settings.grab_focus()
	$AnimationPlayer.play("settings")

func _on_Settings_close_settings():
	Audio.Select.play()
	$AnimationPlayer.play_backwards("settings")
	$Menu/Buttons_Lists/Play.grab_focus()
