extends Control

export(String, FILE) var reload = ""
var queue


func _ready():
	reload = PlayerData.restart_level
	yield(get_tree().create_timer(.1), "timeout")
	get_tree().change_scene(reload)
#		# Initialize.
#	queue = preload("res://Scripts/resource_queue.gd").new()
#	# Call after you instance the class to start the thread.
#	queue.start()
#	set_process(true)
#	queue.queue_resource(reload, true)
#
#func _process(_delta):
#	# Returns true if a resource is done loading and ready to be retrieved.
#	if queue.is_ready(reload):
#		set_process(false)
#		# Returns the fully loaded resource.
#		var reload = queue.get_resource(reload).instance()
#		get_node("/root").add_child(reload)
#		get_parent().queue_free()
#	else:
#		# Get the progress of a resource.
#		var progress = round(queue.get_progress(reload) * 100)
#		get_node("ProgressBar").set_value(progress)
