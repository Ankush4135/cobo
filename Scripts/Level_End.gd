extends Spatial

signal Entered_Tunnel(x)

onready var anim = $AnimationPlayer
onready var orb_prompt = get_node("../UserInterfaceLayer/UserInterface/Pause/not_enough_orbs")
onready var pause = get_node("../UserInterfaceLayer/UserInterface/Pause")
onready var find_button = get_node("../UserInterfaceLayer/UserInterface/Pause/not_enough_orbs/HBoxContainer/find")

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
			anim.play("opengate")
			yield(anim,"animation_finished")
			$orb_checker.free()
		else:
			orb_prompt.visible = true
			find_button.grab_focus()
			yield(get_tree().create_timer(.5),"timeout")
			pause.paused = true

func _on_Entered_Tunnel_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("Entered_Tunnel", endside)
