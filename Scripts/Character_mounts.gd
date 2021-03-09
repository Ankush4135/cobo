extends Spatial

onready var rightmount = $Rot_Z/Rot_X/mount_right
onready var leftmount = $Rot_Z/Rot_X/mount_left
onready var antinamount = $Rot_Z/Rot_X/mount_antina

func _ready():
	var current_ear_mount = PlayerData.player_info[2]["current ear mount"]
	var current_antina_mount = PlayerData.player_info[3]["current antina mount"]

	var ear_mount = load("res://Objects/Character/Ear_mount_" + str(current_ear_mount) + ".tscn")
	var antina_mount = load("res://Objects/Character/Ear_Antina_"+ str(current_antina_mount) + ".tscn")
	
	var antina = antina_mount.instance()
	var mountright = ear_mount.instance()
	var mountleft = ear_mount.instance()
	
	
	rightmount.add_child(mountright)
	leftmount.add_child(mountleft)
	antinamount.add_child(antina)

