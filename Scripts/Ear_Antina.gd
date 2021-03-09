extends MeshInstance

func _ready():
	if LevelManager.level_mode == 0:
		$Glow.visible = false
		$Glowlight.visible = false
	if LevelManager.level_mode == 1:
		$Glow.visible = true
		$Glowlight.visible = true
	if LevelManager.level_mode == 2:
		$Glow.visible = false
		$Glowlight.visible = false
