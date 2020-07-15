extends AnimationTree


var rotspeed = 10

var rot_trans = Vector2(0,0)
var rot_dig = Vector2(1,0)

func _ready():
	active = true

func _physics_process(delta):
	if PlayerData.Die == false:
		if Input.is_action_pressed("left"):
			rot_dig.x = -1
		if Input.is_action_pressed("right"):
			rot_dig.x = 1
	
	rot_trans = rot_trans.linear_interpolate(rot_dig, rotspeed * delta)
	self["parameters/left_right_blend/blend_position"] = rot_trans.x
