extends Spatial

export (bool) var Ear_Static = false
export (bool) var Antina_Static = false

var color

onready var rightmount = $Rot_Z/Rot_X/mount_right
onready var leftmount = $Rot_Z/Rot_X/mount_left
onready var antinamount = $Rot_Z/Rot_X/mount_antina

func _process(delta):
	color = PlayerData.Mount_Color
	if Ear_Static == true:
		rightmount.get_child(0).get_surface_material(0).set_albedo(color)
		leftmount.get_child(0).get_surface_material(0).set_albedo(color)

