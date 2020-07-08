extends Spatial

signal force_position (x, y, z, boolen)

var force_pos = Vector3()

onready var anim = $AnimationPlayer
onready var position = $Position3D

func _ready():
	force_pos = position.get_global_transform().origin

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("force_position", force_pos.x, force_pos.y, force_pos.z, true)
		anim.play("activate")
		yield(get_tree().create_timer(3),"timeout")
		emit_signal("force_position", force_pos.x, force_pos.y, force_pos.z, false)
		anim.play("deactivate")

