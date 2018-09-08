/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

isNonPriorityInteractable = true;
isLit = false;
lightRadius = noone;
lightRadiusAlpha = .5;
lightRadiusScale = 1.5;
lightRadiusColor = c_orange;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

system = part_system_create();
emitter = part_emitter_create(system);
part_system_depth(system,layer_get_depth(layer)-1);
// fire particle
var fire = part_type_create();
part_type_sprite(fire,spr_particle_fire,0,0,1);
part_type_size(fire,.05,.15,0,0);
part_type_color2(fire,c_orange,c_red);
part_type_alpha3(fire,1,1,0);
part_type_speed(fire,4,10,0,0);
part_type_direction(fire,85,95,0,5);
part_type_orientation(fire,0,359,0,0,0);
part_type_blend(fire,1);
part_type_life(fire,5,8);
particle1 = fire;
		
// cinder Particle
var cinder = part_type_create();
part_type_shape(cinder,pt_shape_flare);
part_type_size(cinder,0,.1,0,0);
part_type_color2(cinder,c_orange,c_red);
part_type_alpha3(cinder,1,1,0); 
part_type_speed(cinder,1,2,0,0);
part_type_direction(cinder,85,95,0,0);
part_type_blend(cinder,1);
part_type_life(cinder,25,50);
particle2 = cinder;

part_emitter_region(system, emitter, x-10, x+10, y-10, y+10, ps_shape_diamond, ps_distr_gaussian);