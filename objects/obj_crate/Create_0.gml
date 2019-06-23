/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// holder pieces 1
var p1 = part_type_create();
part_type_sprite(p1,spr_crate_particles,0,0,1);
part_type_size(p1,1,1,0,0);
part_type_alpha3(p1,1, .5, .25);
part_type_speed(p1,2,3 ,0,0);
part_type_direction(p1,0,360,0,10);
part_type_orientation(p1,0,360,5,15,1);
part_type_blend(p1,0);
part_type_life(p1,15,30);

// holder pieces 2
var p2 = part_type_create();
part_type_sprite(p2,spr_crate_particles,0,0,1);
part_type_size(p2,1,1,0,0);
part_type_alpha3(p2,1, .5, .25);
part_type_speed(p2,2,3,0,0);
part_type_direction(p2,0,360,0,10);
part_type_orientation(p2,0,360,-5,15,1);
part_type_blend(p2,0);
part_type_life(p2,15,30);

// dust
var dust = part_type_create();
part_type_shape(dust, pt_shape_sphere);
part_type_color2(dust,c_olive,c_dkgray);
part_type_orientation(dust,0,0,0,15,1);
part_type_size(dust,0,0.15,0,0);
part_type_speed(dust,2,4,0,0);
part_type_direction(dust,0,360,0,4);
part_type_life(dust,20,40);

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_dkgray,c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);

particles = [[p1, 6], [p2, 6], [smoke, 15], [dust, 15]];

destructionSound = snd_wood_shatter ;
