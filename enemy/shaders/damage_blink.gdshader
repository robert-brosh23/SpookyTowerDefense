shader_type canvas_item;

instance uniform bool see_uv = false;
uniform vec3 damage_color : source_color = vec3(1.0, 1.0, 1.0);

void fragment() {
	vec2 uv = UV;
	
	if (see_uv) {
		COLOR = vec4(uv, 0.0, 1.0);
	} else {
		COLOR = vec4(damage_color, COLOR.a);
	}
}

void vertex() {
	
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
