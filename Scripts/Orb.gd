extends Spatial

onready var anim = $AnimationPlayer

func _on_Energy_Ball_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.orbs +=1
		anim.play("Pickedup")
		$Spatial.queue_free()
		yield(anim, "animation_finished")
		queue_free()
