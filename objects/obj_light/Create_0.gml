/// @description init shadow casting
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
VertexFormat = vertex_format_end();

VBuffer = vertex_create_buffer();

surf = -1;

owner = global.owner;
color = global.lightColor;
colorAlpha = global.lightColorAlpha;

LightPosRadius = shader_get_uniform(shader0,"u_fLightPositionRadius");