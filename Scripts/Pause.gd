extends Control

signal gotohome 
signal restart_level
signal goto_orb
signal goto_next_level
signal playbutton_pressed

onready var scene_tree = get_tree()
onready var animation = $AnimationPlayer
onready var pausebg = $PauseBG
onready var timer = $Resume_Counter_Text/Timer
onready var resume_count = $Resume_Counter_Text
onready var title = $pause_menu/ColorRect/Title
onready var orb_prompt = $Control/not_enough_orbs
onready var hint_count_text = $Control/not_enough_orbs/HBoxContainer/hint/TextureRect/Label

var paused: = false setget set_paused
var health_reduced_ui_pause = false
var timescale = 1

func _ready():
	PlayerData.connect("player_died", self, "_player_died")
	hint_count_text.text = str(PlayerData.hints)

func _unhandled_input(event):
	if LevelManager.winned:
		return
	if event.is_action_pressed("pause"):
		if paused == false and PlayerData.Die == false:
			if health_reduced_ui_pause == true:
				Engine.time_scale = timescale
			$pause_menu/ColorRect/HBoxContainer/Play.grab_focus()
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

func set_paused(value):
	paused = value
	scene_tree.paused = value
	pausebg.visible = value
	Input.set_mouse_mode(0)

func _on_Restart_button_up():
	Audio.Select.play()
	if PlayerData.Die == false:
		self.paused = !self.paused
	emit_signal("restart_level")
	Input.set_mouse_mode(1)

func _on_Play_pressed():
	Audio.Select.play()
	animation.play("pause_out")
	emit_signal("playbutton_pressed")
	yield(animation,"animation_finished")
	resume_count.visible = true
	timer.start()
	yield(timer,"timeout")
	self.paused = !self.paused
	resume_count.visible = false
	Input.set_mouse_mode(1)
	

func _on_Home_pressed():
	Audio.Select.play()
	if PlayerData.Die == false:
		self.paused = !self.paused
	emit_signal("gotohome")

func _player_died():
	if PlayerData.Die == true:
		Input.set_mouse_mode(0)
		$pause_menu/ColorRect/HBoxContainer/Play.visible = false
		title.text = "Died"
		yield(get_tree().create_timer(1), "timeout") #delay it then execute
		$pause_menu/ColorRect/HBoxContainer/Restart.grab_focus()
		animation.play("Pause_in")
		yield(animation,"animation_finished")


func _on_find_pressed():
	self.paused = !self.paused
	orb_prompt.visible = false
	Input.set_mouse_mode(1)

func _on_hint_pressed():
	if PlayerData.hints > 0:
		PlayerData.hints -= 1
		hint_count_text.text = str(PlayerData.hints)
		orb_prompt.visible = false
		emit_signal("goto_orb")
	else:
		$not_enough_orbs/HBoxContainer/hint.disabled = true

func _on_Next_pressed():
	Audio.Select.play()
	self.paused = !self.paused
	emit_signal("goto_next_level")
	Input.set_mouse_mode(1)


func _on_health_value_changed(value):
	health_reduced_ui_pause = true
	yield(get_tree().create_timer(0.5), "timeout")
	health_reduced_ui_pause = false
