extends Spatial

onready var pause = get_node("../UserInterfaceLayer/UserInterface/Pause")
onready var anim = $AnimationPlayer

var timescale = 1

func _ready():
	pass

func _process(delta):
	Engine.time_scale = timescale

func _on_Collect_Coins_body_entered(body):
	if body.is_in_group("player"):
		anim.play("Collect_Coins")
		yield(anim,"animation_finished")
		$Collect_Coins.queue_free()

func _on_Avoid_Attract_Force_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Avoid_Attract")
		yield(anim,"animation_finished")
		timescale = 1
		$Avoid_Attract_Force.queue_free()

func _on_UserInterface_health_changed():
	anim.play("Avoid_Spike_on_health_reduce")

func _on_Bounce_Forces_Force_body_entered(body):
	if body.is_in_group("player"):
		timescale = 0.2
		anim.play("Bounce_Forces_Force")
		yield(anim,"animation_finished")
		timescale = 1
		$Bounce_Forces_Force.queue_free()


