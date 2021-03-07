extends Control

signal Play_Level(path)

onready var Scroll = $Set/ScrollContainer
onready var total_coins = $total_coinscount
onready var scroller = get_node("Set/ScrollContainer")

var buttons


var dir = 1
var scroll = 0
var multply = 50
var current_scroll_value = 0
var new_scroll_Value = 0

func _ready():
	total_coins.text = str(PlayerData.player_info[1]["total score"])
	$Set/ScrollContainer/HBoxContainer/Button_1/Level_Button.grab_focus()
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1920, 1080))
	buttons = get_tree().get_nodes_in_group("level_button")
	for button in buttons:
		button.connect("Play_Level_Path", self, "_on_level_button_pressed")

func _process(delta):
	if Input.is_action_pressed("scroll_left"): # leves scroll buttons 
		multply +=delta * 50
		scroll += delta * multply * -1
		current_scroll_value = scroller.get_h_scroll()
		new_scroll_Value = current_scroll_value + scroll
		scroller.set_h_scroll(new_scroll_Value)
	elif Input.is_action_pressed("scroll_right"):
		multply +=delta * 50
		scroll += delta * multply * 1
		current_scroll_value = scroller.get_h_scroll()
		new_scroll_Value = current_scroll_value + scroll
		scroller.set_h_scroll(new_scroll_Value)
	else:
		scroll = 0
		
	if Input.is_action_just_pressed("back"):
		_on_Back_Button_pressed()
		


func _on_level_button_pressed(path):
	$LoadingScreen.visible = true
	emit_signal("Play_Level",path)


func _on_Back_Button_pressed():
	Audio.Select.play()
	var path = "res://Scenes/Main.tscn"
	$LoadingScreen.visible = true
	emit_signal("Play_Level",path)
