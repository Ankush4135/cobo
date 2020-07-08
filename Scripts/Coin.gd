extends Area


func _on_Coin_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.score += 1
		queue_free()

