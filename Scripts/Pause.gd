extends Control

signal gotohome 
signal restart_level

onready var scene_tree = get_tree()
onready var animation = $AnimationPlayer
onready var pausebg = $PauseBG
onready var timer = $Resume_Counter_Text/Timer
onready var resume_count = $Resume_Counter_Text
onready var title = $pause_menu/ColorRect/Title

var paused: = false setget set_paused


func _ready():
	PlayerData.connect("player_died", self, "_player_died")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if paused == false:
			animation.play("Pause_in")
			self.paused = !self.paused
			if paused == false:
				self.paused = !self.paused
				animation.play("pause_out")
				yield(animation,"animation_finished")
				resume_count.visible = true
				timer.start()
				yield(timer,"timeout")
				self.paused = !self.paused
				resume_count.visible = false

func _process(delta):
	var time_left = timer.get_time_left()
	resume_count.text = str((int(time_left) + 1))
	$pause_menu/ColorRect/HBoxContainer/Play.visible = !PlayerData.Die

func set_paused(value):
	paused = value
	scene_tree.paused = value
	pausebg.visible = value

func _on_Restart_button_up():
	if PlayerData.Die == false:
		self.paused = !self.paused
	emit_signal("restart_level")

func _on_Play_pressed():
	animation.play("pause_out")
	yield(animation,"animation_finished")
	resume_count.visible = true
	timer.start()
	yield(timer,"timeout")
	self.paused = !self.paused
	resume_count.visible = false
	

func _on_Home_pressed():
	if PlayerData.Die == false:
		self.paused = !self.paused
	emit_signal("gotohome")
	

func _player_died():
	if PlayerData.Die == true:
		title.text = "Died"
		yield(get_tree().create_timer(1), "timeout") #delay it then execute
		animation.play("Pause_in")
		yield(animation,"animation_finished")
#		self.paused = !self.paused
#		PlayerData.Die = false


