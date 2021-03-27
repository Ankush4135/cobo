extends Control

signal close_settings

onready var music_slider = $Panel/music_Sound/music_Volume
onready var sfx_slider = $Panel/sfx_Sound/sfx_Volume
onready var fps_checkbox = $Panel/Fps/Fps_CheckButton
onready var fullscreen_button = $Panel/Fullscreen/Fullscreen_CheckButton
onready var fulltouch = $Panel/Android_control_mode/FullTouch
onready var touchbutton = $Panel/Android_control_mode/TouchButton


func _ready():
	if OS.get_name() == "Android":
		$Panel/Android_control_mode.visible = true
		$Panel/Fullscreen.visible = false
	else:
		$Panel/Android_control_mode.visible = false
		$Panel/Fullscreen.visible = true
	
	music_slider.value = ConfigManager.music_volume
	sfx_slider.value = ConfigManager.sfx_volume
	fps_checkbox.pressed = ConfigManager.ToggleFps
	fullscreen_button.pressed = ConfigManager.ToggleFullScreen
	if ConfigManager.control_mode == 0:
		touchbutton.pressed = true
	else:
		fulltouch.pressed = true

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

func _on_TouchButton_toggled(button_pressed):
	fulltouch.pressed = !button_pressed
	if button_pressed:
		ConfigManager.control_mode = 0
	else:
		ConfigManager.control_mode = 1

func _on_FullTouch_toggled(button_pressed):
	touchbutton.pressed = !button_pressed
	if button_pressed:
		ConfigManager.control_mode = 1
	else:
		ConfigManager.control_mode = 0
