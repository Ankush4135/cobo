extends CanvasLayer

onready var animation = $AnimationPlayer
onready var colorec = $ColorRect

export var Fadein = false


func _ready():
	if Fadein == true:
		animation.play("Fadein")
