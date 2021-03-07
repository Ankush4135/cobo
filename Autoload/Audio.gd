extends Node

onready var BG = $Background_music
onready var BG2 = $Background_music2
onready var Death = $Death
onready var Bounce = $Bounce_object
onready var Orb = $Orb
onready var Coin = $Coin
onready var Select = $Select

var music_volume = 0
var sfx_volume = 0

func _ready():
	pass

func _process(delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), ConfigManager.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), ConfigManager.sfx_volume)

func set_volume():
	if ConfigManager.music_volume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), 0)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), 0)
