
isRunning = false;
isDoneFilling = false;

lightRadius = 256;
lightRadiusAlpha = .35;
lightRadiusScale = .75;
lightRadiusColor = c_aqua;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
nativeRoom = room_get_name(room);
event_inherited();

// override on instance creation
spawnX = postX + 100;
spawnY = postY + 100;

system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);
particle = noone;

num = random_range(10,25);
// water particle
var water = part_type_create();
part_type_shape(water, pt_shape_sphere);
part_type_color2(water,c_aqua,c_ltgray);
part_type_orientation(water,0,0,0,15,1);
part_type_size(water,0,0.05,0,0);
part_type_speed(water,2,3,0,0);
part_type_direction(water,0,360,0,4);
part_type_life(water,7,11);
particle = water;

origLayer = layer;
layerName = layer_get_name(layer);

inUse = false;





// shader for ripple
uni_time = shader_get_uniform(shd_radial_blur,"time");
var_time_var = 0;

uni_mouse_pos = shader_get_uniform(shd_radial_blur,"mouse_pos");
var_mouse_pos_x = x;
var_mouse_pos_y = y;

uni_resolution = shader_get_uniform(shd_radial_blur,"resolution");
var_resolution_x = view_get_wport(0);
var_resolution_y = view_get_hport(0);

uni_radial_blur_offset = shader_get_uniform(shd_radial_blur,"radial_blur_offset");
var_radial_blur_offset = 0.05;

uni_radial_brightness = shader_get_uniform(shd_radial_blur,"radial_brightness");
var_radial_brightness = 1;




/*
key = fs_generate_key();
data = noone;
with obj_persistent_environment_data_parent {
	if key == other.key {
		other.data = id;
	}
}




