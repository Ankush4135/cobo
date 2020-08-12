extends Control

signal Play_Level(path)

onready var Scroll = $Set/ScrollContainer

var buttons
#var scroll_started = true

func _ready():
	$Set/ScrollContainer/HBoxContainer/Button_1.grab_focus()
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	buttons = get_tree().get_nodes_in_group("level_button")
	for button in buttons:
		button.connect("Play_Level_Path", self, "_on_level_button_pressed")

func _on_level_button_pressed(path):
	$LoadingScreen.visible = true
	emit_signal("Play_Level",path)

func _exit_tree():
	Audio.BG.stop()
