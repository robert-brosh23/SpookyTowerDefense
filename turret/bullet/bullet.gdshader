shader_type canvas_item;

uniform vec3 shadow_color : source_color = vec3(0.0, 0.0, 0.0);

void fragment() {
	COLOR = vec4(shadow_color, COLOR.a * .5);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
