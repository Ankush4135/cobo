extends Node

signal scene_changed(path) 

onready var loading_scene = $LoadingScreen
onready var animation = $Scene_trans/AnimationPlayer
onready var colorec = $Scene_trans/ColorRect


export(String, FILE) var Change_Scene = ""
export(String, FILE) var Tutorial_Level = ""


func _ready():
	PlayerData.total_score = PlayerData.player_info[1]["total score"]
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	$Menu/Buttons_Lists/Play.grab_focus()
	$quit_popup.visible = false
	Audio.BG.play()
	if OS.get_name() == "Android":
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Android1.visible = true
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Android2.visible = true
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Computer1.visible = false
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Computer2.visible = false
	else:
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Android1.visible = false
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Android2.visible = false
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Computer1.visible = true
		$how_to_play/Panel/MarginContainer/ScrollContainer/HBoxContainer/Computer2.visible = true
		
func _process(delta):
	if Input.is_action_just_pressed("back"):
		if $Settings.visible: # setting menue close and save settings
			ConfigManager.save_config()
			_on_Settings_close_settings()
		elif $quit_popup.visible: # quit popup close
			_on_quit_cancel_pressed()
		elif $Particles/CPUParticles2D.emitting == false: # character customiser close and save customise data 
			if $Customise/no_enough_coins_popup.visible == false:
				Audio.Select.play()
				PlayerData.save_data()
				$Menu/Buttons_Lists/Play.grab_focus()
				$AnimationPlayer.play_backwards("Customise")
				$Character_Tile_Scene/AnimationPlayer.play_backwards("Customise")
			else:
				$Customise/no_enough_coins_popup.visible = false
				Audio.Select.play()
		elif $how_to_play.visible == true:
			Audio.Select.play()
			$AnimationPlayer.play_backwards("how_to_play")
			$Menu/Buttons_Lists/Play.grab_focus()
		else:
			_on_Quit_button_up()

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
	$Settings/Settings_Pannel/confirm_settings.grab_focus()
	$AnimationPlayer.play("settings")

func _on_Settings_close_settings():
	Audio.Select.play()
	$AnimationPlayer.play_backwards("settings")
	$Menu/Buttons_Lists/Play.grab_focus()

func _on_Customise_pressed():
	Audio.Select.play()
	$Customise/Purchase/Buy_Button.grab_focus()
	$AnimationPlayer.play("Customise")
	$Character_Tile_Scene/AnimationPlayer.play("Customise")
	

func _on_How_to_play_pressed():
	Audio.Select.play()
	$how_to_play/Play_Tutorial.grab_focus()
	$AnimationPlayer.play("how_to_play")


func _on_Play_Tutorial_pressed():
	emit_signal("scene_changed", Tutorial_Level)
	Audio.Select.play()
	loading_scene.visible = true

