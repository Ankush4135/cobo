extends Spatial

export  var Follow_Target = NodePath()
onready var Target = get_node(Follow_Target)

var Target_position = Vector3()
var offset = Vector3()
var follow = true
var died = false

func _ready():
	PlayerData.connect("player_died", self, "_player_died")
	Target_position = Target.get_translation()
	offset = self.get_translation() - Target_position

func _process(delta):
	var Changing_Position = Vector3()
	Target_position = Target.get_translation()
	Changing_Position = Target_position + offset
	if follow == true: #follow player only if the player is not die
		self.set_translation(Changing_Position)

func _player_died(): #if player is die
	if PlayerData.Die == true:
		yield(get_tree().create_timer(.8), "timeout") #delay it then execute
		follow = false
	

