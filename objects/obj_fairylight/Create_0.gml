/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

material = WOOD;

depth += 1; // hands appear over light
stopsAttacks = false;

lightRadius = noone;
lightRadiusAlpha = .1;
lightRadiusScale = .2;
lightRadiusColor = make_color_rgb(75, 208, 161);
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,depth,obj_light_radius);

depth = layer_get_depth(layer) + 5;

system = part_system_create();
part_system_depth(system,layer_get_depth(origLayer));
emitter = part_emitter_create(system);
// particle
particle = part_type_create();
part_type_shape(particle, pt_shape_cloud);
part_type_color2(particle,c_aqua,c_white);
part_type_alpha2(particle,.55,.15);
part_type_orientation(particle,0,0,0,15,1);
part_type_size(particle,0.1,0.25,0,0);
part_type_speed(particle,.05,.15,0,0);
part_type_direction(particle,0,360,0,4);
part_type_life(particle,30,60);

