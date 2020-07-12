extends Node

signal score_Update
signal reduce_health
signal player_died
signal total_score_update
#signal has_orbs

var restart_level = "" setget set_restart_level
var total_score = 0 setget set_total_score
var score = 0 setget set_score, get_score
var health = 100 setget set_health
var orbs = 0 setget _set_orbs

var health_reduced = 2.5

var Die = false setget set_die

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

func set_restart_level(reload):
	restart_level = reload

func _set_orbs(update_orb):
	orbs = update_orb
#	emit_signal("has_orbs")





