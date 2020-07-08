extends Spatial

onready var rightmount = $Rot_Z/Rot_X/mount_right
onready var leftmount = $Rot_Z/Rot_X/mount_left
onready var antinamount = $Rot_Z/Rot_X/mount_antina

func _ready():
	var mount = load("res://Objects/Character/Ear_mount01.tscn")
	var ant = load("res://Objects/Character/Ear_Antina01.tscn")
	var antina = ant.instance()
	var mountright = mount.instance()
	var mountleft = mount.instance()
	
	rightmount.add_child(mountright)
	leftmount.add_child(mountleft)
	antinamount.add_child(antina)

