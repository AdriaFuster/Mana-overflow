shader_type canvas_item;

uniform bool use_silhouette = false;

void fragment() {
	COLOR = vec4(1.0, 0.0, 0.0, 1.0); 
	vec4 tex = texture(TEXTURE, UV);

    if (tex.a < 0.01) {
        discard;
    }

    if (use_silhouette) {
        COLOR = vec4(0.0, 0.0, 0.0, tex.a);
    } else {
        COLOR = tex;
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
