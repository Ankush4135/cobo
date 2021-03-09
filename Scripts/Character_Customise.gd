extends Spatial

export (Color) var Ball_Color
export (Color) var Mount_Color

func _process(delta):
	$character_1/Ball.color = Ball_Color
	$character_1/Character_mounts.mount_color = Mount_Color
