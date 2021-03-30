  
extends Node

onready var path = "user://config.cfg"
var sfx_volume = 0
var music_volume = 0
var ToggleFps = false
var ToggleFullScreen = true
var control_mode = 0

func _ready():
	load_config()

func save_config():
	var config = ConfigFile.new()
	config.set_value("audio", "sfx", sfx_volume)
	config.set_value("audio", "music", music_volume)
	config.set_value("UI", "fps", ToggleFps)
	config.set_value("UI", "fullscreen", ToggleFullScreen)
	config.set_value("android_controls", "controls", control_mode)
	
	var err = config.save(path)
	if err != OK:
		print("something went wrong")

func load_config():
	var config = ConfigFile.new()
	var default_options = {
			"sfx": 0,
			"music": 0,
			"fps": false,
			"fullscreen": false,
			"controls": 0
			}
	var err = config.load(path)
	if err != OK:
		return default_options
	var options = {}
	sfx_volume = config.get_value("audio", "sfx", default_options.sfx)
	music_volume = config.get_value("audio", "music", default_options.music)
	ToggleFps = config.get_value("UI", "fps", default_options.fps)
	ToggleFullScreen = config.get_value("UI", "fullscreen", default_options.fullscreen)
	control_mode = config.get_value("android_controls", "controls",default_options.controls)
	return options
