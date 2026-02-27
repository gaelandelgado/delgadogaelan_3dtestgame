shader_type spatial;
render_mode unshaded, cull_disabled, blend_add;

uniform vec3 orb_color : source_color = vec3(1.0, 0.6, 0.1);
uniform float glow_intensity : hint_range(0.1, 5.0) = 1.5;

varying vec3 world_normal;

void vertex() {
    world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
}

void fragment() {
    vec3 view_dir = normalize(VIEW);
    float fresnel = 1.0 - abs(dot(world_normal, view_dir));
    fresnel = pow(fresnel, 3.5);

    float center_glow = 1.0 - pow(fresnel, 0.4);
    center_glow = smoothstep(0.0, 1.0, center_glow) * 0.4;

    float total_alpha = clamp(fresnel + center_glow, 0.0, 1.0);

    ALBEDO = orb_color * glow_intensity * total_alpha;
    ALPHA = total_alpha;
    EMISSION = orb_color * glow_intensity * (fresnel + center_glow * 0.5);
}
