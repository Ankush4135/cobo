extends Spatial

onready var pause = get_node("../UserInterfaceLayer/UserInterface/Pause")
onready var anim = $AnimationPlayer
onready var fulltouch = $For_Activate_Buttons/Android_Controls_Selection/FullTouch
onready var touchbutton = $For_Activate_Buttons/Android_Controls_Selection/TouchButton
onready var Touch_Controls = get_node("../TouchcontolsLayer/Touch_Contols")
onready var Touch_Buttons = get_node("../TouchcontolsLayer/Touch_Buttons")
onready var Android_Controls = $For_Activate_Buttons/Android_Controls_Selection

var timescale = 1

func _ready():
	if OS.get_name() == "Android":
		Android_Controls.visible = true
		yield(get_tree().create_timer(1), "timeout")
		Input.set_mouse_mode(0)
		pause.paused = true
	else:
		Android_Controls.visible = false

func _process(delta):
	if LevelManager.winned == false:
		Engine.time_scale = timescale

func _on_Collect_Coins_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Collect_Coins")
		yield(anim,"animation_finished")
		timescale = 1
		$Collect_Coins.queue_free()

func _on_Avoid_Attract_Force_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Avoid_Attract")
		yield(anim,"animation_finished")
		timescale = 1
		$Avoid_Attract_Force.queue_free()

func _on_UserInterface_health_changed():
	timescale = 0.2
	anim.play("Avoid_Spike_on_health_reduce")
	yield(anim,"animation_finished")
	timescale = 1

func _on_Bounce_Forces_Force_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Bounce_Forces_Force")
		yield(anim,"animation_finished")
		timescale = 1
		$Bounce_Forces_Force.queue_free()


func _on_TouchButton_toggled(button_pressed):
	fulltouch.pressed = !button_pressed
	pause.paused = false
	Input.set_mouse_mode(1)
	fulltouch.get_parent().visible = false
	if button_pressed:
		ConfigManager.control_mode = 0
	else:
		ConfigManager.control_mode = 1
	
	if ConfigManager.control_mode == 0:
		Touch_Buttons.visible = true
		Touch_Controls.visible = false
	else:
		Touch_Buttons.visible = false
		Touch_Controls.visible = true
	ConfigManager.save_config()

func _on_FullTouch_toggled(button_pressed):
	touchbutton.pressed = !button_pressed
	pause.paused = false
	Input.set_mouse_mode(1)
	fulltouch.get_parent().visible = false
	if button_pressed:
		ConfigManager.control_mode = 1
	else:
		ConfigManager.control_mode = 0

	if ConfigManager.control_mode == 0:
		Touch_Buttons.visible = true
		Touch_Controls.visible = false
	else:
		Touch_Buttons.visible = false
		Touch_Controls.visible = true
	ConfigManager.save_config()


func _on_Collect_Orbs_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Collect_Orbs")
		yield(anim,"animation_finished")
		timescale = 1
		$Collect_Orbs.queue_free()
