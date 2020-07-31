extends Node

var restart_level = "" setget set_restart_level
var play_level = "" setget set_play_level
var next_level = "" setget set_next_level
var level_mode = 0

#level cleared variables
var level_1_cleared = false
var level_2_cleared = false
var level_3_cleared = false
var level_4_cleared = false
var level_5_cleared = false
var level_6_cleared = false
var level_7_cleared = false
var level_8_cleared = false
var level_9_cleared = false
var level_10_cleared = false

func set_play_level(play):
	play_level = play

func set_restart_level(reload):
	restart_level = reload

func set_next_level(next):
	next_level = next

