extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	OS.window_fullscreen = ConfigManager.ToggleFullScreen

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
