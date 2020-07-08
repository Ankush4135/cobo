extends Spatial

signal force_position (x, y, z)

onready var anime = get_node("../../Character_Follow/Character_mounts/Chanacter_Animation")

var force_pos = Vector3()


func _ready():
	force_pos = get_translation()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("force_position", force_pos.x, force_pos.y, force_pos.z)
		#send it Position to the player 
		anime.play("collision")


