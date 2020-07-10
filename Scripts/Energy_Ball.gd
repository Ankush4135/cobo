extends Spatial



func _on_Energy_Ball_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.score += 5
		queue_free()
