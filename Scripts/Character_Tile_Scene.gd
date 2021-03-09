extends Spatial

onready var camera_pivot = $Camera_pivot
onready var character_selector = $Character

var mouse_dir = Vector2()
var mouse_position = Vector2()
var speed = 25
var gyro = Vector3()

var character_select = 1

func _process(delta):
	gyro = Input.get_gyroscope()
	mouse_position = get_viewport().get_mouse_position()
	camera_pivot.rotation.x = gyro.x / speed
	camera_pivot.rotation.y = gyro.y / speed
#	print(mouse_position)


func _on_rigth_Customise_Button_pressed():
	if character_select < 5:
		character_select += 1
		$AnimationPlayer.play("character_customise_" + str(character_select))
	print(character_select)


func _on_left_Customise_Button_pressed():
	if character_select > 1:
		$AnimationPlayer.play_backwards("character_customise_" + str(character_select))
		character_select -= 1
	print(character_select)
	

