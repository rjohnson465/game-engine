/// prepareLayerShader()

/// static -- get the layer shader object for this instance's layer

var shader = noone;
var l = object_index == obj_fountain ? origLayer : layer;
with obj_layer_shader {
	if pseudoLayer == l {
		shader = id;
	}
}

if shader == noone return noone;

shader_set(sh_saturation);
var uPOSITION = shader_get_uniform(sh_saturation, "Position");
shader_set_uniform_f(uPOSITION,shader.shade);