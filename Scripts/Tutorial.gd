extends Spatial

onready var pause = get_node("../UserInterfaceLayer/UserInterface/Pause")
onready var anim = $AnimationPlayer
onready var fulltouch = $For_Activate_Buttons/Android_Controls_Selection/FullTouch
onready var touchbutton = $For_Activate_Buttons/Android_Controls_Selection/TouchButton
onready var Touch_Controls = get_node("../TouchcontolsLayer/Touch_Contols")
onready var Touch_Buttons = get_node("../TouchcontolsLayer/Touch_Buttons")
onready var Android_Controls = $For_Activate_Buttons/Android_Controls_Selection
onready var Level_Indicater = get_node("../UserInterfaceLayer/UserInterface/main_UI/level_indicate")
var timescale = 1

func _ready():
	Level_Indicater.visible = false
	if OS.get_name() == "Android":
		Android_Controls.visible = true
		yield(get_tree().create_timer(1), "timeout")
		Input.set_mouse_mode(0)
		pause.paused = true
#		$Controls_Info/Controls_Info/Computer_Controls.visible = false
#		if ConfigManager.control_mode == 0:
#			$Controls_Info/Controls_Info/Android_Touch_Buttons.visible = true
#			$Controls_Info/Controls_Info/Android_Full_Touch.visible = false
#		else:
#			$Controls_Info/Controls_Info/Android_Touch_Buttons.visible = false
#			$Controls_Info/Controls_Info/Android_Touch_Buttons.visible = true
	else:
		Android_Controls.visible = false
		$Controls_Info/Controls_Info/Computer_Controls.visible = true
		$Controls_Info/Controls_Info/Android_Full_Touch.visible = false
		$Controls_Info/Controls_Info/Android_Touch_Buttons.visible = false

func _process(delta):
	if LevelManager.winned == false:
		Engine.time_scale = timescale
	pass

func _on_Controls_Info_body_exited(body):
	anim.play("Controls_Info")
	yield(anim,"animation_finished")
	$Controls_Info/Controls_Info.visible = false

func _on_Collect_Coins_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Collect_Coins")
		yield(anim,"animation_finished")
		timescale = 1
		$Collect_Coins.queue_free()

func _on_Both_Buttons_ToGo_Straignt_Up_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Both_Buttons_ToGo_Straignt_Up")
		yield(anim,"animation_finished")
		timescale = 1
		$Both_Buttons_ToGo_Straignt_Up.queue_free()

func _on_Avoid_Attract_Force_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Avoid_Attract")
		yield(anim,"animation_finished")
		timescale = 1
		$Avoid_Attract_Force.queue_free()

func _on_Release_Both_Buttons_ToGo_Down_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Release_Both_Buttons_ToGo_Down")
		yield(anim,"animation_finished")
		timescale = 1
		$Release_Both_Buttons_ToGo_Down.queue_free()

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
	$Controls_Info/Controls_Info/Android_Touch_Buttons.visible = true

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
	$Controls_Info/Controls_Info/Android_Full_Touch.visible = true

func _on_Collect_Orbs_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Collect_Orbs")
		yield(anim,"animation_finished")
		timescale = 1
		$Collect_Orbs.queue_free()

func _on_Try_to_Be_in_air_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Try_to_Be_in_air")
		yield(anim,"animation_finished")
		timescale = 1
		$Try_to_Be_in_air.queue_free()



