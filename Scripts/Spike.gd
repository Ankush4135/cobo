extends Area

onready var anime = get_node("../../Character_Follow/Character_mounts/Chanacter_Animation")

func _on_Spike_body_entered(body):
	if body.is_in_group("player"):
		PlayerData.health -= 100 / PlayerData.health_reduced  #it send the date to the autoload 
		anime.play("collision")
