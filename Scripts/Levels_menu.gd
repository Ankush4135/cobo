extends Control

signal Play_Level(path)

onready var Scroll = $Set/ScrollContainer
onready var total_coins = $total_coinscount
var buttons
#var scroll_started = true

func _ready():
	print(str(PlayerData.player_info[1]["total score"]))
#	total_coins.text = str(PlayerData.total_score)
	total_coins.text = str(PlayerData.player_info[1]["total score"])
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
