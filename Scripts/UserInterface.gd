extends Control

signal reload_scene

onready var coinscore = $main_UI/coinscount
onready var timer_label = $main_UI/Timer_Text
onready var timer = $main_UI/Timer
onready var health_value = $main_UI/health
onready var scene_trans_anim = get_node("../../Scene_trans/AnimationPlayer")
onready var camerashake = get_node("../Shake_Camera")

var shake = false
export(float) var Max_Time



func _ready():
	PlayerData.health = 100 #reset helth on start
	PlayerData.Die = false
	coinscore.text = str(PlayerData.score)
	PlayerData.connect("score_Update", self, "update_text" )
	PlayerData.connect("reduce_health", self, "update_health")
	timer.set_wait_time(Max_Time)
	timer.start()
	
func _process(delta):
	var time_left = timer.get_time_left()
	timer_label.text = str((int(time_left))) #how much time left to complete the level


func update_text(): #coin collected 
	coinscore.text = str(PlayerData.score)
	
	
func update_health(): #Current Health
	health_value.value = float(PlayerData.health)


func _on_Pause_gotohome(): # this will change scene to the main scene
	scene_trans_anim.play("Fadeout")
	yield(scene_trans_anim, "animation_finished")
	scene_trans_anim.play("strech")
	yield(scene_trans_anim,"animation_finished")
	get_parent().get_parent().queue_free()
	get_tree().change_scene("res://Scenes/Main.tscn")
	

func _on_Pause_restart_level(): # restart the level
	emit_signal("reload_scene")


func _on_health_value_changed(value):
	if health_value.value == 0:
		PlayerData.Die = true


func _on_Timer_timeout():
	PlayerData.Die = true
