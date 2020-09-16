extends Node

signal score_Update
signal reduce_health
signal player_died

onready var path = "user://player.dat"

var total_score = 0 setget set_total_score
var score = 0 setget set_score, get_score
var health = 100 setget set_health
var orbs = 0 setget _set_orbs
var hints = 3
var health_reduced = 2.5
var Die = false setget set_die

var player_info = {}
var default_player_info = {
	1:{
		"total score": 5
		}
	}

func _ready():
	player_info = load_data()
#	player_info = default_player_info
	save_data()

func save_data():
	var file = File.new()
	var err = file.open(path, File.WRITE)
	if err != OK:
		print ("something went wrong")
		return
	file.store_var(player_info)
	file.close()

func load_data():
	var file = File.new()
	var err = file.open(path, File.READ)
	if err != OK:
		return default_player_info
		print("something happened")
	var read = {}
	read = file.get_var()
	return read

func set_total_score(totalscore):
	total_score = totalscore

func set_score(updated_Score):
	score = updated_Score
	emit_signal("score_Update")

func get_score():
	return score

func set_health(update_health):
	health = update_health
	emit_signal("reduce_health")
	
func set_die(died):
	Die = died
	emit_signal("player_died")

func _set_orbs(update_orb):
	orbs = update_orb





