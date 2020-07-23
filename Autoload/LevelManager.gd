extends Node

var restart_level = "" setget set_restart_level
var play_level = "" setget set_play_level
var next_level = "" setget set_next_level
var level_mode = 0 setget set_level_mode

func set_play_level(play):
	play_level = play

func set_restart_level(reload):
	restart_level = reload

func set_next_level(next):
	next_level = next

func set_level_mode(mode):
	level_mode = mode
