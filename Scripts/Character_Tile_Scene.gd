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
onready var purchase = get_node("../Customise/Purchase")
onready var popup = get_node("../Customise/no_enough_coins_popup")
onready var coin_coint = get_node("../Customise/total_coinscount")
onready var tab = get_node("../Customise/TabContainer")

export (Color) var Ball_Color
export (Color) var Mount_Color

var mouse_dir = Vector2()
var mouse_position = Vector2()
var speed = 25
var gyro = Vector3()

var selected_character = 1
var selected_ear_mount = 1
var selected_antina_mount = 1

var current_tab = 0
var character_select = 1
var ear_mount_select = 1
var antina_mounts_select = 1

var max_characters = 5
var max_ear_mount = 3
var max_antina_mount = 3


func _ready():
	character_select = PlayerData.player_info[2]["current character"]
	ear_mount_select = PlayerData.player_info[3]["current ear mount"]
	antina_mounts_select = PlayerData.player_info[4]["current antina mount"]
	
	selected_character = PlayerData.player_info[2]["current character"]
	selected_ear_mount = PlayerData.player_info[3]["current ear mount"]
	selected_antina_mount = PlayerData.player_info[4]["current antina mount"]
	
	character_counter_lable.text = str(character_select) + "/" + str(max_characters)
	ear_mount_counter_lable.text = str(ear_mount_select) + "/" + str(max_ear_mount)
	antina_mount_counter_lable.text = str(antina_mounts_select) + "/" + str(max_antina_mount)
	
	coin_coint.text = str(PlayerData.player_info[1]["total score"])
	
	var cpos = Vector3(-7 * (character_select -1),0,0)
	var epos = Vector3(-7 * (ear_mount_select -1),0,0)
	var apos = Vector3(-7 * (antina_mounts_select -1),0,0)
	$Character.translate(cpos)
	$Character_ear_mounts.translate(epos)
	$Character_Antina_mounts.translate(apos)
	_last_selected_unlocked()

func _process(delta):
	gyro = Input.get_gyroscope()
	mouse_position = get_viewport().get_mouse_position()
	camera_pivot.rotation.x = gyro.x / speed
	camera_pivot.rotation.y = gyro.y / speed
	PlayerData.Ball_Color = Ball_Color
	PlayerData.Mount_Color = Mount_Color
	_selector_visisbality()
	
	if get_node("../Customise").visible == true:
		if Input.is_action_just_pressed("left"):
			_on_left_Customise_Button_pressed()
		if Input.is_action_just_pressed("right"):
			_on_rigth_Customise_Button_pressed()
		if Input.is_action_just_pressed("scroll_left"):
			tab.current_tab -=1
		if Input.is_action_just_pressed("scroll_right"):
			tab.current_tab +=1
		


func _on_TabContainer_tab_changed(tab): # it will set current tab from player to ear mount to antina mount
	Audio.Select.play()
	current_tab = tab
	
	var cpos = Vector3(-7 * (selected_character -1),0,0)
	var epos = Vector3(-7 * (selected_ear_mount -1),0,0)
	var apos = Vector3(-7 * (selected_antina_mount -1),0,0)
	$Character.translation = cpos
	$Character_ear_mounts.translation = epos
	$Character_Antina_mounts.translation = apos
	character_counter_lable.text = str(selected_character) + "/" + str(max_characters)
	ear_mount_counter_lable.text = str(selected_ear_mount) + "/" + str(max_ear_mount)
	antina_mount_counter_lable.text = str(selected_antina_mount) + "/" + str(max_antina_mount)
	character_select = selected_character
	ear_mount_select = selected_ear_mount
	antina_mounts_select = selected_antina_mount
	_selector_visisbality()
	_last_selected_unlocked()

func _on_rigth_Customise_Button_pressed():
	Audio.Select.play()
	if current_tab == 0: # check it has player tab
		if character_select < max_characters: # limit total characters
			if $AnimationPlayer.is_playing() == false:
				character_select += 1
				$AnimationPlayer.play("character_customise_" + str(character_select))
				character_counter_lable.text = str(character_select) + "/" + str(max_characters)
				PlayerData.player_info[2]["current character"] = character_select

	if current_tab == 1:
		if ear_mount_select < max_ear_mount:
			if $AnimationPlayer.is_playing() == false:
				ear_mount_select +=1
				$AnimationPlayer.play("ear_customise_" + str(ear_mount_select))
				ear_mount_counter_lable.text = str(ear_mount_select) + "/" + str(max_ear_mount)
				PlayerData.player_info[3]["current ear mount"] = ear_mount_select

	if current_tab == 2:
		if antina_mounts_select < max_antina_mount:
			if $AnimationPlayer.is_playing() == false: 
				antina_mounts_select += 1
				$AnimationPlayer.play("antina_customise_" + str(antina_mounts_select))
				antina_mount_counter_lable.text = str(antina_mounts_select) + "/" + str(max_antina_mount)
				PlayerData.player_info[4]["current antina mount"] = antina_mounts_select
	_last_selected_unlocked()

func _on_left_Customise_Button_pressed():
	Audio.Select.play()
	if current_tab == 0:
		if character_select > 1:
			if $AnimationPlayer.is_playing() == false:
				$AnimationPlayer.play_backwards("character_customise_" + str(character_select))
				character_select -= 1
				character_counter_lable.text = str(character_select) + "/" + str(max_characters)
				PlayerData.player_info[2]["current character"] = character_select

	if current_tab == 1:
		if ear_mount_select > 1:
			if $AnimationPlayer.is_playing() == false:
				$AnimationPlayer.play_backwards("ear_customise_" + str(ear_mount_select))
				ear_mount_select -=1
				ear_mount_counter_lable.text = str(ear_mount_select) + "/" + str(max_ear_mount)
				PlayerData.player_info[3]["current ear mount"] = ear_mount_select

	if current_tab == 2:
		if antina_mounts_select > 1:
			if $AnimationPlayer.is_playing() == false: 
				$AnimationPlayer.play_backwards("antina_customise_" + str(antina_mounts_select))
				antina_mounts_select -= 1
				antina_mount_counter_lable.text = str(antina_mounts_select) + "/" + str(max_antina_mount)
				PlayerData.player_info[4]["current antina mount"] = antina_mounts_select
	_last_selected_unlocked()

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

func _last_selected_unlocked():
	# these function will check weather selected character is unlocked or not if it's not then it will select previous unlocked selection 
	if current_tab == 0:
		if PlayerData.player_info[2]["character " + str(character_select) + " unlocked"] == false:
			while PlayerData.player_info[2]["character " + str(selected_character) +" unlocked"] == false and selected_character < max_characters:
				selected_character +=1
			purchase.visible = true
			purchase.get_child(0).text = str(PlayerData.player_info[2]["character " + str(character_select) + " prise"])
		else:
			selected_character = character_select
			purchase.visible = false

	if current_tab == 1:
		if PlayerData.player_info[3]["ear mount " + str(ear_mount_select) + " unlocked"] == false:
			while PlayerData.player_info[3]["ear mount " + str(selected_ear_mount) +" unlocked"] == false and selected_ear_mount < max_ear_mount:
				selected_ear_mount +=1
			purchase.visible = true
			purchase.get_child(0).text = str(PlayerData.player_info[3]["ear mount " + str(ear_mount_select) + " prise"])
		else:
			selected_ear_mount = ear_mount_select
			purchase.visible = false
		
	if current_tab == 2:
		if PlayerData.player_info[4]["ear antina " + str(antina_mounts_select) + " unlocked"] == false:
			while PlayerData.player_info[4]["ear antina " + str(selected_antina_mount) +" unlocked"] == false and selected_antina_mount < max_antina_mount:
				selected_character +=1
			purchase.visible = true
			purchase.get_child(0).text = str(PlayerData.player_info[4]["ear antina " + str(antina_mounts_select) + " prise"])
		else:
			selected_antina_mount = antina_mounts_select
			purchase.visible = false

	# it will assign to the data
	PlayerData.player_info[2]["current character"] = selected_character
	PlayerData.player_info[3]["current ear mount"] = selected_ear_mount
	PlayerData.player_info[4]["current antina mount"] = selected_antina_mount

func _on_Buy_Button_pressed():
	popup.get_child(1).get_child(1).grab_focus()
	var update_coins
	if int(purchase.get_child(0).text) <= PlayerData.player_info[1]["total score"]:
		update_coins = PlayerData.player_info[1]["total score"] - int(purchase.get_child(0).text)
		$AnimationPlayer.play("Purchase")
		PlayerData.player_info[1]["total score"] = update_coins
		PlayerData.player_info[2]["character " + str(character_select) + " unlocked"] = true
		PlayerData.player_info[3]["ear mount " + str(ear_mount_select) + " unlocked"] = true
		PlayerData.player_info[4]["ear antina " + str(antina_mounts_select) + " unlocked"] = true
		coin_coint.text = str(PlayerData.player_info[1]["total score"])
		_last_selected_unlocked()
	else:
		popup.visible = true
	
	print(PlayerData.player_info[1]["total score"])
	
func _on_no_enough_coins_ok_pressed():
	Audio.Select.play()
	popup.visible = false
	purchase.get_child(0).grab_focus()
