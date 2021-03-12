extends Spatial

onready var camera_pivot = $Camera_pivot
onready var character_selector = $Character
onready var character_counter_lable = get_node("../Customise/TabContainer/Player/character_counter")
onready var ear_mount_counter_lable = get_node("../Customise/TabContainer/Ear Mount/ear_mount_counter")
onready var antina_mount_counter_lable = get_node("../Customise/TabContainer/Antina/antina_mount_counter")
onready var right_button_c = get_node("../Customise/TabContainer/Player/rightbuttonholder")
onready var left_button_c = get_node("../Customise/TabContainer/Player/leftbuttonholder")
onready var right_button_e = get_node("../Customise/TabContainer/Ear Mount/rightbuttonholder2")
onready var left_button_e = get_node("../Customise/TabContainer/Ear Mount/leftbuttonholder2")
onready var right_button_a = get_node("../Customise/TabContainer/Antina/rightbuttonholder3")
onready var left_button_a = get_node("../Customise/TabContainer/Antina/leftbuttonholder3")


export (Color) var Ball_Color
export (Color) var Mount_Color

var mouse_dir = Vector2()
var mouse_position = Vector2()
var speed = 25
var gyro = Vector3()

var current_tab = 0
var character_select = 1
var ear_mount_select = 1
var antina_mounts_select = 1

func _ready():
	character_select = PlayerData.player_info[2]["current character"]
	ear_mount_select = PlayerData.player_info[3]["current ear mount"]
	antina_mounts_select = PlayerData.player_info[4]["current antina mount"]
	
	character_counter_lable.text = str(character_select) + "/5"
	ear_mount_counter_lable.text = str(ear_mount_select) + "/3"
	antina_mount_counter_lable.text = str(antina_mounts_select) + "/3"
	
	
	var cpos = Vector3(-7 * (character_select -1),0,0)
	var epos = Vector3(-7 * (ear_mount_select -1),0,0)
	var apos = Vector3(-7 * (antina_mounts_select -1),0,0)
	$Character.translate(cpos)
	$Character_ear_mounts.translate(epos)
	$Character_Antina_mounts.translate(apos)

func _process(delta):
	gyro = Input.get_gyroscope()
	mouse_position = get_viewport().get_mouse_position()
	camera_pivot.rotation.x = gyro.x / speed
	camera_pivot.rotation.y = gyro.y / speed
	PlayerData.Ball_Color = Ball_Color
	PlayerData.Mount_Color = Mount_Color
	_selector_visisbality()


func _on_TabContainer_tab_changed(tab): # it will set current tab from player to ear mount to antina mount
	current_tab = tab

func _on_rigth_Customise_Button_pressed():
	if current_tab == 0: # check it has player tab
		if character_select < 5: # limit total characters
			if $AnimationPlayer.is_playing() == false:
				character_select += 1
				$AnimationPlayer.play("character_customise_" + str(character_select))
				character_counter_lable.text = str(character_select) + "/5"
				PlayerData.player_info[2]["current character"] = character_select

	if current_tab == 1:
		if ear_mount_select < 3:
			if $AnimationPlayer.is_playing() == false:
				ear_mount_select +=1
				$AnimationPlayer.play("ear_customise_" + str(ear_mount_select))
				ear_mount_counter_lable.text = str(ear_mount_select) + "/3"
				PlayerData.player_info[3]["current ear mount"] = ear_mount_select

	if current_tab == 2:
		if antina_mounts_select < 3:
			if $AnimationPlayer.is_playing() == false: 
				antina_mounts_select += 1
				$AnimationPlayer.play("antina_customise_" + str(antina_mounts_select))
				antina_mount_counter_lable.text = str(antina_mounts_select) + "/3"
				PlayerData.player_info[4]["current antina mount"] = antina_mounts_select



func _on_left_Customise_Button_pressed():
	if current_tab == 0:
		if character_select > 1:
			if $AnimationPlayer.is_playing() == false:
				$AnimationPlayer.play_backwards("character_customise_" + str(character_select))
				character_select -= 1
				character_counter_lable.text = str(character_select) + "/5"
				PlayerData.player_info[2]["current character"] = character_select


	if current_tab == 1:
		if ear_mount_select > 1:
			if $AnimationPlayer.is_playing() == false:
				$AnimationPlayer.play_backwards("ear_customise_" + str(ear_mount_select))
				ear_mount_select -=1
				ear_mount_counter_lable.text = str(ear_mount_select) + "/3"
				PlayerData.player_info[3]["current ear mount"] = ear_mount_select

	if current_tab == 2:
		if antina_mounts_select > 1:
			if $AnimationPlayer.is_playing() == false: 
				$AnimationPlayer.play_backwards("antina_customise_" + str(antina_mounts_select))
				antina_mounts_select -= 1
				antina_mount_counter_lable.text = str(antina_mounts_select) + "/3"
				PlayerData.player_info[4]["current antina mount"] = antina_mounts_select


func _selector_visisbality():
	if current_tab == 0:
		if character_select == 5:
			right_button_c.visible = false
		elif character_select == 1:
			left_button_c.visible = false
		else:
			right_button_c.visible = true
			left_button_c.visible = true
	else:
		right_button_c.visible = true
		left_button_c.visible = true


	if current_tab == 1:
		if ear_mount_select == 3:
			right_button_e.visible = false
		elif ear_mount_select == 1:
			left_button_e.visible = false
		else:
			right_button_e.visible = true
			left_button_e.visible = true
	else:
		right_button_e.visible = true
		left_button_e.visible = true


	if current_tab == 2:
		if antina_mounts_select == 3:
			right_button_a.visible = false
		elif antina_mounts_select == 1:
			left_button_a.visible = false
		else:
			right_button_a.visible = true
			left_button_a.visible = true
	else:
		right_button_a.visible = true
		left_button_a.visible = true





