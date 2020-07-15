extends Spatial

onready var anim = $AnimationPlayer

func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.score += 1
		anim.play("picked")
		$Coin_Pickup_Detect.queue_free()
		yield(anim,"animation_finished")
		queue_free()

