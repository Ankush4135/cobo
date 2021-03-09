extends Spatial

onready var camera_pivot = $Camera_pivot
onready var character_selector = $Character

export (Color) var Ball_Color
export (Color) var Mount_Color

var mouse_dir = Vector2()
var mouse_position = Vector2()
var speed = 25
var gyro = Vector3()

var current_tab = 0
var character_select = 1
#var current_character_pos = Vector3(0,0,0)
#var character_target_pos = Vector3(0,0,0)

func _process(delta):
	gyro = Input.get_gyroscope()
	mouse_position = get_viewport().get_mouse_position()
	camera_pivot.rotation.x = gyro.x / speed
	camera_pivot.rotation.y = gyro.y / speed
#	print(mouse_position)

func _on_TabContainer_tab_changed(tab): # it will set current tab from player to ear mount to antina mount
	current_tab = tab

func _on_rigth_Customise_Button_pressed():
	if current_tab == 0: # check it has player tab
		if character_select < 5: # limit total characters
			if $AnimationPlayer.is_playing() == false:
				character_select += 1
				$AnimationPlayer.play("character_customise_" + str(character_select))
				PlayerData.player_info[2]["current character"] = character_select


func _on_left_Customise_Button_pressed():
	if current_tab == 0:
		if character_select > 1:
			if $AnimationPlayer.is_playing() == false:
				$AnimationPlayer.play_backwards("character_customise_" + str(character_select))
				character_select -= 1
				PlayerData.player_info[2]["current character"] = character_select
	

