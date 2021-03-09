extends Spatial

onready var fadeanim = $Scene_trans/AnimationPlayer
onready var camerashake = $Shake_Camera
onready var playeranim = $Ball/AnimationPlayer
onready var UI_anim = $UserInterfaceLayer/UserInterface/Pause/AnimationPlayer
onready var pause = $UserInterfaceLayer/UserInterface/Pause
onready var admob  = $AdMob

export(int, "Level 01", "Level 02", "Level 03", "Level 04", "Level 05",
		 "Level 06", "Level 07", "Level 08", "Level 09", "Level 10",
		 "Level 11") var Current_Level

var Current_Scene_Path = ""
var Next_Scene_Path = ""
var timescale = 1

var coin_count = 0
var play_anim = ""
var star_count = 0
var total_score = 0
var save_score = 0

func _ready():
	Audio.BG.stop()
	Current_Scene_Path = "res://Scenes/Levels/Level_" + str(Current_Level + 1) + ".tscn"
	Next_Scene_Path = "res://Scenes/Levels/Level_" + str(Current_Level + 2) + ".tscn"
	_level_selector()
	Audio.BG2.play()
	LevelManager.winned = false
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1920, 1080))
	var coin_list
	coin_list = get_tree().get_nodes_in_group("coins")
	coin_count = coin_list.size()

func _process(delta):
	Engine.time_scale = timescale
	
	if LevelManager.winned == true or PlayerData.Die == true: # check weather player is cleared or either die then save total score
		if save_score == 0:
			PlayerData.total_score += PlayerData.score # it will add current score to total
			PlayerData.player_info[1]["total score"] = PlayerData.total_score 
			PlayerData.save_data()
			save_score += 1   # this will stop this loop

func _level_selector():
	#for level mode 
	if LevelManager.level_mode == 0:
		pass
	if LevelManager.level_mode == 1:
		$DirectionalLight.visible = false
		$DirectionalLight2.visible = false
	if LevelManager.level_mode == 2:
		PlayerData.health_reduced = 1

func _on_reload_scene_pressed():
	fadeanim.play("Fadeout")
	yield(fadeanim,"animation_finished")
	LevelManager.restart_level = Current_Scene_Path
	get_tree().change_scene("res://Scenes/Reload_Helper.tscn")
	queue_free()

func _on_Game_End_Triger_body_entered(body):
	LevelManager.winned = true
	if body.is_in_group("player"):
		Audio.Wall_Smash.play()
		timescale = 0.2
		if PlayerData.score <= coin_count/3:
			play_anim = "one_Star"
			star_count = 1
		if PlayerData.score >= coin_count/3:
			play_anim = "two_Star"
			star_count = 2
		if PlayerData.score >= coin_count/1.2:
			play_anim = "three_Star"
			star_count = 3
		yield(get_tree().create_timer(.1), "timeout")
		UI_anim.play(play_anim)
		yield(UI_anim,"animation_finished")
		yield(get_tree().create_timer(.01), "timeout")
		timescale = 1
		UI_anim.play("end_button_animation")
		pause.paused = true

	if LevelManager.level_info.has(int(Current_Level + 2)): # it unlocks next level
		 #it set the stars on the current level button
		if star_count > LevelManager.level_info[int(Current_Level + 1)]["stars unlocked"]:
			LevelManager.level_info[int(Current_Level + 1)]["stars unlocked"] = star_count
		LevelManager.level_info[int(Current_Level + 2)]["disabled"] = false
		LevelManager.save_data()
	

func _on_next_scene_pressed():
	fadeanim.play("Fadeout")
	LevelManager.next_level = Next_Scene_Path
	yield(fadeanim,"animation_finished")
	get_tree().change_scene("res://Scenes/LoadingScreen.tscn")
	queue_free()

func _on_health_changed(): #chamera shake on every hit when the helth is decreased
	camerashake.shake(0.1, 20, 0.18)
	playeranim.play("Collided")

func _exit_tree():
	Audio.BG2.stop()


