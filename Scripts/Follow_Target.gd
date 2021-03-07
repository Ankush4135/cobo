extends Spatial


export  var Follow_Target = NodePath()
onready var Target = get_node(Follow_Target)

var Target_position = Vector3()
var offset = Vector3()


func _ready():
	Target_position = Target.get_translation()
	offset = self.get_translation() - Target_position

func _process(delta): # _physics_process is creating visual intrest(delay) in character mounts
	var Changing_Position = Vector3()
	Target_position = Target.get_translation()
	Changing_Position = Target_position + offset
	self.set_translation(Changing_Position)
