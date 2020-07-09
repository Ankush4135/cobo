extends RigidBody

# geting the taget left Position
export  var Target_L_path = NodePath()
onready var Target_L = get_node(Target_L_path)
var Target_L_position = Vector3()
# geting the taget Right Position
export  var Target_R_path = NodePath()
onready var Target_R = get_node(Target_R_path)
var Target_R_position = Vector3()
# how much player will move
var Player_Pos = Vector3()
export var  Impulse_power = float(01) 
var Impulse_dir_L = Vector3()
var Impulse_dir_R = Vector3()
var attract_force = false
var attract_pos = Vector3()

onready var camerashake = get_node("../Shake_Camera")

func _ready():
	PlayerData.connect("player_died", self, "_player_died")

func _physics_process(delta):
	Target_L_position = Target_L.get_global_transform().origin
	Target_R_position = Target_R.get_global_transform().origin
	Player_Pos = get_translation()
	
	if PlayerData.Die == false:
		if Input.is_action_pressed("left"):
			Impulse_dir_L = (Player_Pos - Target_L_position).normalized() * -Impulse_power * delta
			apply_impulse(Vector3(), Impulse_dir_L)
		if Input.is_action_pressed("right"):
			Impulse_dir_R = (Player_Pos - Target_R_position).normalized() * -Impulse_power * delta
			apply_impulse(Vector3(), Impulse_dir_R)
	
	if attract_force == true:
		var attract_dir
		attract_dir = (Player_Pos - attract_pos).normalized() * 200 * delta
		apply_impulse(Vector3(), -attract_dir)
		yield(get_tree().create_timer(3),"timeout")

func _on_Bounce_Force_position_Colides(x, y, z):
	camerashake.shake(0.25, 30, 0.18)
	var bounce_dir 
	var bounce_pos = Vector3()
	bounce_pos.x = x
	bounce_pos.y = y
	bounce_dir = (Player_Pos - bounce_pos).normalized() * 50
	apply_impulse(Vector3(), bounce_dir)

func _on_Attract_Force_position_colides(x, y, z, boolen):
	attract_force = boolen
	attract_pos.x = x
	attract_pos.y = y

func _player_died(): # this will happen when the player is died
	if PlayerData.Die == true:
		axis_lock_linear_z = false
		apply_impulse(Vector3(), Vector3(0,-.1,10))
		print("player_died")




