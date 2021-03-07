extends Spatial

signal Entered_Tunnel(x)

onready var anim = $AnimationPlayer
onready var orb_prompt = get_node("../UserInterfaceLayer/UserInterface/Pause/not_enough_orbs")
onready var pause = get_node("../UserInterfaceLayer/UserInterface/Pause")
onready var find_button = get_node("../UserInterfaceLayer/UserInterface/Pause/not_enough_orbs/HBoxContainer/find")
onready var camera = get_node("../Shake_Camera/Camera_Pivot")
onready var tween = get_node("../Shake_Camera/Camera_Pivot/Camera/Tween")

export var End_Right_side = true
var endside = 1
var orb_count = 0

func _ready():
	if End_Right_side == true:
		endside = 1
	else:
		endside = -1
	var orb_list
	orb_list = get_tree().get_nodes_in_group("orb")
	orb_count = orb_list.size()

func _on_orb_checker_body_entered(body):
	if body.is_in_group("player") && anim.is_playing() == false:
		if PlayerData.orbs == orb_count:
			var offset = camera.get_parent().get_translation()
			var cam_old_pos = camera.get_translation()
			var cam_Current_pos = camera.get_translation()
			var camera_target = Vector3()
			yield(get_tree().create_timer(.1),"timeout")
			pause.paused = true
			camera.follow = false
			camera_target = $camera_target.get_global_transform().origin - offset - Vector3(0,0,5)
			tween.interpolate_property(camera, "translation", cam_Current_pos, camera_target, 2,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			tween.start()
			yield(tween,"tween_completed")
			anim.play("opengate")
			yield(anim,"animation_finished")
			cam_Current_pos = camera.get_translation()
			tween.interpolate_property(camera, "translation", cam_Current_pos, cam_old_pos, 1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
			tween.start()
			yield(tween,"tween_completed")
			camera.follow = true
			yield(get_tree().create_timer(.2),"timeout")
			pause.paused = false
			$orb_checker.free()
		else:
			orb_prompt.visible = true
			find_button.grab_focus()
			yield(get_tree().create_timer(.5),"timeout")
			pause.paused = true

func _on_Entered_Tunnel_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("Entered_Tunnel", endside)
