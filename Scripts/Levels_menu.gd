extends Control

signal Play_Level(path)

func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))


func _on_Levels_Set_1_Play_Level_Path(path):
	LevelManager.level_mode = $Set_1/Level_Set_01.get_current_tab()
	$LoadingScreen.visible = true
	emit_signal("Play_Level",path)
