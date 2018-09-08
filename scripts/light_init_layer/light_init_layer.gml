/// light_init_layer(width,height,light_size,color,quality,iterations,layerNum)
/// @param width: Width of the shadow map.
/// @param height: Height of the shadow map.
/// @param light_size: The size of the lightmaps, should be set to the largest light.
/// @param color: The shadow color, this also controls the darkness of the shadows.
/// @param quality: The lightmap quality, 0 to 1.
/// @param iterations: 
/*How many times a second to draw the lightmap. The default is the room speed
            but you might want to reduce this for increased performance. If it is too
            small, however, you will notice considerable stuttering.*/
/// @param layerNum
			
// floorNum corresponds with last digit of "instances_floor_n"
var floorNum = argument6
var map = ds_map_create();

//global._light_width = argument0
ds_map_replace(map,"_light_width",argument0);
//global._light_height = argument1
ds_map_replace(map,"_light_height",argument1);
//global._light_size = argument2
ds_map_replace(map,"_light_size",argument2);
//global._light_half_size = global._light_size / 2
ds_map_replace(map,"_light_half_size",argument2/2);
//global._light_color = argument3
ds_map_replace(map,"_light_color",argument3);
//global._light_quality = argument4
ds_map_replace(map,"_light_quality",argument4);
var _light_max_time = 0;
if argument5 < 0
    _light_max_time = 0
else
    _light_max_time = 1000000/ argument5
ds_map_replace(map,"_light_max_time",_light_max_time);
//global._light_time = 0
ds_map_replace(map,"_light_time",0);
//global._light_surface = surface_create(global._light_size * global._light_quality, global._light_size * global._light_quality)
ds_map_replace(map,"_light_surface",surface_create(argument2 * argument4, argument2 * argument4));
//global._light_map = surface_create(global._light_width * global._light_quality, global._light_height * global._light_quality)
ds_map_replace(map,"_light_map",surface_create(argument0 * argument4, argument1 * argument4));
//global._lights = ds_list_create()
ds_map_replace(map,"_lights",ds_list_create());
//global._light_casters = ds_list_create()
ds_map_replace(map,"_light_casters",ds_list_create());
ds_map_replace(global._light_layers,floorNum,map);