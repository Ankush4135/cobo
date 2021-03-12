extends Node

signal score_Update
signal reduce_health
signal player_died

export (Color) var Ball_Color
export (Color) var Mount_Color

onready var path = "user://player.dat"

var total_score = 0 setget set_total_score, get_total_score
var score = 0 setget set_score, get_score
var health = 100 setget set_health
var orbs = 0 setget _set_orbs
var hints = 3
var health_reduced = 2.5
var Die = false setget set_die

var player_info = {}
var default_player_info = {
	1:{
		"total score": 5000,
		},
	2:{
		"current character" : 1,
		"character color" : Color(1,0.45,0,1),
		"character 1 unlocked" : true,
		"character 2 unlocked" : false,
		"character 3 unlocked" : false,
		"character 4 unlocked" : false,
		"character 5 unlocked" : false,
		"character 1 prise" : 0000,
		"character 2 prise" : 1000,
		"character 3 prise" : 2000,
		"character 4 prise" : 3000,
		"character 5 prise" : 4000,
		"character 1 ad watched" : 0,
		"character 2 ad watched" : 0,
		"character 3 ad watched" : 0,
		"character 4 ad watched" : 0,
		"character 5 ad watched" : 0,
		"character 1 total ads" : 0,
		"character 2 total ads" : 2,
		"character 3 total ads" : 2,
		"character 4 total ads" : 2,
		"character 5 total ads" : 2,
		},
	3:{
		"current ear mount" : 1,
		"ear mount color" : Color(1,0.7,0,1),
		"ear mount 1 unlocked" : true,
		"ear mount 2 unlocked" : false,
		"ear mount 3 unlocked" : false,
		"ear mount 1 prise" : 0000,
		"ear mount 2 prise" : 1000,
		"ear mount 3 prise" : 2000,
		"ear mount 1 ad watche" :0,
		"ear mount 2 ad watche" :0,
		"ear mount 3 ad watche" :0,
		"ear mount 1 total ads" : 0,
		"ear mount 2 total ads" : 2,
		"ear mount 3 total ads" : 2,
		},
	4:{
		"current antina mount": 1,
		"ear antina 1 unlocked" : true,
		"ear antina 2 unlocked" : false,
		"ear antina 3 unlocked" : false,
		"ear antina 1 prise" : 0000,
		"ear antina 2 prise" : 1000,
		"ear antina 3 prise" : 2000,
		"ear antina 1 ad watched" : 0,
		"ear antina 2 ad watched" : 0,
		"ear antina 3 ad watched" : 0,
		"ear antina 1 total ads" : 0,
		"ear antina 2 total ads" : 2,
		"ear antina 3 total ads" : 2,
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

func get_total_score():
	return total_score

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





