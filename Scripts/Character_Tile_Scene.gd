extends Spatial

onready var camera_pivot = $Camera_pivot
var mouse_dir = Vector2()
var mouse_position = Vector2()
var speed = 25
var gyro = Vector3()


func _process(delta):
	gyro = Input.get_gyroscope()
	mouse_position = get_viewport().get_mouse_position()
	camera_pivot.rotation.x = gyro.x / speed
	camera_pivot.rotation.y = gyro.y / speed
#	print(mouse_position)
