shader_type canvas_item;

uniform float direction: hint_range(-1.0, 1.0, 0.1) = 1.0;

g
void vertex() {
    vec2 centered_pos = VERTEX - vec2(0.5);
    float rotation_angle = TIME * 6.0 * direction;
    float cos_a = cos(rotation_angle);
    float sin_a = sin(rotation_angle);

    // Rotation matrix
    mat2 rot = mat2(
        vec2(cos_a, -sin_a),
        vec2(sin_a, cos_a)
    );

    vec2 rotated_pos = rot * centered_pos + vec2(0.5);

    VERTEX = rotated_pos;
}


void fragment() {
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
