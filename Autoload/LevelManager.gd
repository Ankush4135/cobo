extends Node

var restart_level = "" setget set_restart_level
var play_level = "" setget set_play_level
var next_level = "" setget set_next_level
var level_mode = 0
var winned = false

var level_info = {}
var default_level_info = {
	1:{
		"disabled": false,
		"high score": 0,
		"stars unlocked": 0
		},
	2:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	3:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	4:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	5:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	6:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	7:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	8:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	9:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	10:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	11:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	12:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0
		},
	}
onready var path = "user://level.dat"

func _ready():
	level_info = load_data()
#	level_info = default_level_info
	save_data()

func save_data():
	var file = File.new()
	var err = file.open(path, File.WRITE)
	if err != OK:
		print ("something went wrong")
		return
	file.store_var(level_info)
	file.close()

func load_data():
	var file = File.new()
	var err = file.open(path, File.READ)
	if err != OK:
		return default_level_info
		print("something happened")
	var read = {}
	read = file.get_var()
	return read

func set_play_level(play):
	play_level = play

func set_restart_level(reload):
	restart_level = reload

func set_next_level(next):
	next_level = next

