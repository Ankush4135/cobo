extends Control

signal close_settings

onready var music_slider = $Panel/music_Sound/music_Volume
onready var sfx_slider = $Panel/sfx_Sound/sfx_Volume
onready var fps_checkbox = $Panel/Fps/Fps_CheckButton
onready var fullscreen_button = $Panel/Fullscreen/Fullscreen_CheckButton

func _ready():
#	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	music_slider.value = ConfigManager.music_volume
	sfx_slider.value = ConfigManager.sfx_volume
	fps_checkbox.pressed = ConfigManager.ToggleFps
	fullscreen_button.pressed = ConfigManager.ToggleFullScreen

func _on_music_Volume_value_changed(value):
	var volume =0
	if value <= -40:
		volume = -80
	else:
		volume = value
	ConfigManager.music_volume = volume

func _on_sfx_Volume_value_changed(value):
	var volume =0
	if ConfigManager.sfx_volume == value:
		pass
	else:
		Audio.Select.play()
	
	if value <= -40:
		volume = -80
	else:
		volume = value
	
	ConfigManager.sfx_volume = volume
	

func _on_confirm_settings_pressed():
	emit_signal("close_settings")
	ConfigManager.save_config()

func _on_cancel_settings_pressed():
	emit_signal("close_settings")


func _on_Fullscreen_CheckButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	ConfigManager.ToggleFullScreen = button_pressed

func _on_Fps_CheckButton_toggled(button_pressed):
	ConfigManager.ToggleFps = button_pressed
