extends Control

export(String, FILE) var Play_Scene = ""

onready var animation = $AnimationPlayer

var queue
export var Autoload = true

func _ready():
	# Initialize.
	queue = preload("res://Scripts/resource_queue.gd").new()
	# Call after you instance the class to start the thread.
	queue.start()
	if Autoload == true:
		animation.play("Static_BG")
		yield(get_tree().create_timer(.1), "timeout")
		Play_Scene = LevelManager.next_level
		set_process(true)
		queue.queue_resource(Play_Scene, true)


func _process(_delta):
	# Returns true if a resource is done loading and ready to be retrieved.
	if queue.is_ready(Play_Scene):
		set_process(false)
		# Returns the fully loaded resource.
		var play_scene = queue.get_resource(Play_Scene).instance()
		get_node("/root").add_child(play_scene)
		if Autoload == true:
			queue_free()
		else:
			get_parent().queue_free()
	else:
		# Get the progress of a resource.
		var progress = round(queue.get_progress(Play_Scene) * 100)
		get_node("ProgressBar").set_value(progress)


func _on_Main_scene_changed(path): # this one is for main menu
	Play_Scene = path
	animation.play("Fadeout")
	yield(animation, "animation_finished")
	set_process(true)
	queue.queue_resource(Play_Scene, true)


func _on_Reload_Helper_scene(path): # this one is for Reload Scene
	Play_Scene = path
	set_process(true)
	queue.queue_resource(Play_Scene, true)


func _on_Levels_menu_Play_Level(path): # this one is for Level Menu
	Play_Scene = path
	animation.play("Fadeout")
	yield(animation, "animation_finished")
	set_process(true)
	queue.queue_resource(Play_Scene, true)


func _on_End_Screen_Main_Menu_pressed():
	self.visible = true
	animation.play("Fadeout")
	yield(animation, "animation_finished")
	set_process(true)
	queue.queue_resource(Play_Scene, true)


func _on_Splash_Time_timeout():
	self.visible = true
	animation.play("Fadeout")
	yield(animation, "animation_finished")
	set_process(true)
	queue.queue_resource(Play_Scene, true)
