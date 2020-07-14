extends Spatial

onready var fadeanim = $Scene_trans/AnimationPlayer
onready var camerashake = $Shake_Camera
onready var playeranim = $Ball/AnimationPlayer

export(String, FILE) var Current_Scene_Path = ""

func _ready():
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1280, 720))

func _on_reload_scene_pressed():
	fadeanim.play("Fadeout")
	yield(fadeanim,"animation_finished")
	PlayerData.restart_level = Current_Scene_Path
	get_tree().change_scene("res://Scenes/Reload_Helper.tscn")
	queue_free()

func _on_Game_End_Triger_body_entered(body):
	if body.is_in_group("player"):
		yield(get_tree().create_timer(.8), "timeout")
		fadeanim.play("Fadeout")
		yield(fadeanim,"animation_finished")
		get_tree().change_scene("res://Scenes/Game_End.tscn")
		queue_free()

func _on_health_changed(): #chamera shake on every hit when the helth is decreased
	camerashake.shake(0.1, 20, 0.18)
	playeranim.play("Collided")
