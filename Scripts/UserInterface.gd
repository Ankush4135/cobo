extends Control

signal reload_scene
signal health_changed
signal next_scene

onready var coinscore = $main_UI/coinscount
onready var timer_label = $main_UI/Timer_Text
onready var timer = $main_UI/Timer
onready var health_value = $main_UI/health
onready var scene_trans_anim = get_node("../../Scene_trans/AnimationPlayer")
onready var player_anim = get_node("../../Ball/AnimationPlayer")
onready var pause = $Pause
onready var orbs = get_node("../../Orbs")
onready var camera = get_node("../../Shake_Camera/Camera_Pivot")
onready var tween = get_node("../../Shake_Camera/Camera_Pivot/Camera/Tween")
onready var wait_time = $main_UI/health_update_Wait_time
var wait = true

export(float) var Max_Time
export(String) var Level_Number = 01

func _ready():
	$main_UI/level_indicate.text = "LEVEL " +  str(Level_Number)
	PlayerData.orbs = 0
	PlayerData.score = 0
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
	if time_left < 31:
		timer_label.add_color_override("font_color", Color(1,0,0))
		timer_label.rect_scale = Vector2(1.5,1.5)
	

func update_text(): #coin collected 
	coinscore.text = str(PlayerData.score)
	
func update_health(): #Current Health
		if wait:
			wait = false
			wait_time.start()
			PlayerData.health -= 100 / PlayerData.health_reduced  #it send the date to the autoload 
			yield(wait_time,"timeout")
			wait = true
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
	emit_signal("health_changed")
	if health_value.value == 0:
		PlayerData.Die = true

func _on_Timer_timeout():
	PlayerData.Die = true

func _on_Pause_goto_orb():
	var offset = camera.get_parent().get_translation()
	var cam_Current_pos = camera.get_translation()
	var orb_pos = Vector3()
	camera.follow = false
	orb_pos = orbs.get_child(0).get_global_transform().origin - offset
	tween.interpolate_property(camera, "translation", cam_Current_pos, orb_pos, 2,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_completed")
	yield(get_tree().create_timer(2),"timeout")
	camera.follow = true
	yield(get_tree().create_timer(.5),"timeout")
	pause.paused = false

func _on_Pause_goto_next_level():
	emit_signal("next_scene")
