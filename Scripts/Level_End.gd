extends Spatial

signal Entered_Tunnel(x)

onready var anim = $AnimationPlayer

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
	if body.is_in_group("player"):
		if PlayerData.orbs == orb_count:
			anim.play("opengate")
			yield(anim,"animation_finished")
			$orb_checker.free()
		else:
			print("you dont have enough orbs")

func _on_Entered_Tunnel_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("Entered_Tunnel", endside)
