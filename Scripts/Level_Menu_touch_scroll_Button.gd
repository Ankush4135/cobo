extends TouchScreenButton

onready var scroller = get_node("../../Set/ScrollContainer")

export var dir = 1

var scroll = 0
var multply = 50
var current_scroll_value = 0
var new_scroll_Value = 0
func _ready():
	set_process(false)
	
func _process(delta):
	multply +=delta * 50
	scroll += delta * multply * dir
	current_scroll_value = scroller.get_h_scroll()
	new_scroll_Value = current_scroll_value + scroll
	scroller.set_h_scroll(new_scroll_Value)

func _on_TouchScreenButton_pressed():
	set_process(true)
	scroll = 0

func _on_TouchScreenButton_released():
	set_process(false)
