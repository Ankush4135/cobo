extends Control

export(String, FILE) var Next_Scene = ""

onready var animation = $AnimationPlayer

var queue


func _ready():
	# Initialize.
	queue = preload("res://Scripts/resource_queue.gd").new()
	# Call after you instance the class to start the thread.
	queue.start()
#	queue.queue_resource(Next_Scene, true)


func _process(_delta):
	# Returns true if a resource is done loading and ready to be retrieved.
	if queue.is_ready(Next_Scene):
		set_process(false)
		# Returns the fully loaded resource.
		var next_scene = queue.get_resource(Next_Scene).instance()
		get_node("/root").add_child(next_scene)
		get_parent().queue_free()
	else:
		# Get the progress of a resource.
		var progress = round(queue.get_progress(Next_Scene) * 100)
		get_node("ProgressBar").set_value(progress)


func _on_Main_scene_changed(path): # this one is for main menu
	Next_Scene = path
	animation.play("Fadeout")
	yield(animation, "animation_finished")
	set_process(true)
	queue.queue_resource(Next_Scene, true)
	

