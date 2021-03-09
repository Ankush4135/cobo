extends MeshInstance

var color


#func _ready():
#	var current_mat = Mat
#	var texture_base = load("res://Assets/Textures/Character/Character_Ball_" +str(current_mat) + "_Base_Color.png")
#	var texture_normal = load("res://Assets/Textures/Character/Character_Ball_" +str(current_mat) + "_Normal.png")
#
#	self.get_surface_material(0).set_shader_param("Albedo", texture_base)
#	self.get_surface_material(0).set_shader_param("Normal", texture_normal)
	
func _process(delta):
	color = PlayerData.Ball_Color
	self.get_surface_material(0).set_shader_param("Color", color)
