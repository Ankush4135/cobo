extends Node

onready var BG = $Background_music
onready var BG2 = $Background_music2
onready var Death = $Death
onready var Bounce = $Bounce_object
onready var Orb = $Orb
onready var Coin = $Coin
onready var Select = $Select

func _ready():
#	set_volume()
	pass

#func set_volume():
#	if ConfigManager.sound_on:
#		BG.volume_db = -15
#		BG2.volume_db = -15
#	else:
#		BG.volume_db = -80
#		BG2.volume_db = -80
