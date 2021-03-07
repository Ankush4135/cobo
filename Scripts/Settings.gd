extends Control

signal close_settings

onready var music_slider = $Panel/music_Sound/music_Volume
onready var sfx_slider = $Panel/sfx_Sound/sfx_Volume

func _ready():
#	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	music_slider.value = ConfigManager.music_volume
	sfx_slider.value = ConfigManager.sfx_volume


func _on_music_Volume_value_changed(value):
	ConfigManager.music_volume = value


func _on_sfx_Volume_value_changed(value):
	ConfigManager.sfx_volume = value
	Audio.Select.play()

func _on_confirm_settings_pressed():
	emit_signal("close_settings")
	ConfigManager.save_config()

func _on_cancel_settings_pressed():
	emit_signal("close_settings")
