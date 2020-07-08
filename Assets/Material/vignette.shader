shader_type canvas_item;

uniform float radius = 0.75;
uniform float softness = 0.45;

void fragment() {
	float len = length(UV - vec2(0.5));
	float vignette = smoothstep(radius, radius-softness, len);
	
	COLOR.rgb = vec3(0.0);
	COLOR.a = 1.0 - vignette*0.5-0.5;
}