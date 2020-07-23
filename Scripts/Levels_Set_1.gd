extends GridContainer

signal Play_Level_Path(path)

export(int, "Normal", "Dark", "Onetouch") var Level_Mode

func _ready():
	var buttons = get_tree().get_nodes_in_group("level_button")
	for button in buttons:
		button.connect("level_path_pressed", self, "_on_level_button_pressed")

func _on_level_button_pressed(path):
	var level = path
	LevelManager.level_mode = Level_Mode
#	LevelManager.play_level = path
	emit_signal("Play_Level_Path",level)

