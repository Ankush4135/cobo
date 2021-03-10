extends MeshInstance

var color


func _process(delta):
	color = PlayerData.Ball_Color
	self.get_surface_material(0).set_shader_param("Color", color)
