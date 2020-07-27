extends Spatial

onready var anim = $AnimationPlayer

func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.score += 1
		anim.play("picked")
		$Coin_Pickup_Detect.queue_free()
		Audio.Coin.play(0.0)
		yield(anim,"animation_finished")
		queue_free()

