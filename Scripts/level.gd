extends Spatial

onready var fadeanim = $Scene_trans/AnimationPlayer
onready var camerashake = $Shake_Camera
onready var playeranim = $Ball/AnimationPlayer
onready var UI_anim = $UserInterfaceLayer/UserInterface/Pause/AnimationPlayer
onready var pause = $UserInterfaceLayer/UserInterface/Pause

export(String, FILE) var Current_Scene_Path = ""

var coin_count = 0
var play_anim = ""

func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280, 720))
	var coin_list
	coin_list = get_tree().get_nodes_in_group("coins")
	coin_count = coin_list.size()

func _on_reload_scene_pressed():
	fadeanim.play("Fadeout")
	yield(fadeanim,"animation_finished")
	PlayerData.restart_level = Current_Scene_Path
	get_tree().change_scene("res://Scenes/Reload_Helper.tscn")
	queue_free()

func _on_Game_End_Triger_body_entered(body):
	if body.is_in_group("player"):
		if PlayerData.score <= coin_count/3:
			play_anim = "one_Star"
		if PlayerData.score >= coin_count/3:
			play_anim = "two_Star"
		if PlayerData.score >= coin_count/1.2:
			play_anim = "three_Star"
		yield(get_tree().create_timer(.8), "timeout")
		UI_anim.play(play_anim)
		yield(UI_anim,"animation_finished")
		yield(get_tree().create_timer(.2), "timeout")
		pause.paused = true

func _on_next_scene_pressed():
	fadeanim.play("Fadeout")
	yield(fadeanim,"animation_finished")
	get_tree().change_scene("res://Scenes/Game_End.tscn")
	queue_free()

func _on_health_changed(): #chamera shake on every hit when the helth is decreased
	camerashake.shake(0.1, 20, 0.18)
	playeranim.play("Collided")

func _exit_tree():
	PlayerData.total_score += PlayerData.score


