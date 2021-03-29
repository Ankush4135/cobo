extends Node

var restart_level = "" setget set_restart_level
var play_level = "" setget set_play_level
var next_level = "" setget set_next_level
var level_mode = 0
var winned = false

var Levels_Theme = {
	1:{ #cyan
		"ambient_color": Color("004c4c"),
		"character_color": Color("ff7200"),
		"character_mount_Color": Color("ffb300"),
		"wall_albedo": Color("052d2d"),
		"wall_emission": Color("00caca"),
		"level_floor": Color("008e8e"),
		"fog": false
		},
	2:{ #yellow
		"ambient_color": Color("484c00"),
		"character_color": Color("ff0095"),
		"character_mount_Color": Color("f100ff"),
		"wall_albedo": Color("2c2e05"),
		"wall_emission": Color("b5ca00"),
		"level_floor": Color("8a8e00"),
		"fog": false
		},
	}

var level_info = {}
var default_level_info = {
	0:{
		"disabled": false,
		"high score": 0,
		"stars unlocked": 0,
		},
	1:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	2:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	3:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	4:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	5:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	6:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	7:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	8:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	9:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	10:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	11:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	12:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	13:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	14:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	15:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	16:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	17:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	18:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	19:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	20:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	21:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	22:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	23:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	24:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	25:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	26:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	27:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	28:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	29:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
		},
	30:{
		"disabled": true,
		"high score": 0,
		"stars unlocked": 0,
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

