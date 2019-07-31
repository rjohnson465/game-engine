/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// dust
var dust = part_type_create();
part_type_shape(dust, pt_shape_sphere);
part_type_color2(dust,c_olive,c_dkgray);
part_type_orientation(dust,0,0,0,15,1);
part_type_size(dust,0,0.15,0,0);
part_type_speed(dust,2,4,0,0);
part_type_direction(dust,0,360,0,4);
part_type_life(dust,20,40);

// wing particle
var p1 = part_type_create();
part_type_sprite(p1,spr_factory_wings,0,0,1);
part_type_size(p1,1,1,0,0);
part_type_alpha3(p1,1, .5, .25);
part_type_speed(p1,5,6,0,0);
part_type_direction(p1,0,360,0,10);
part_type_orientation(p1,0,360,10,15,1);
part_type_blend(p1,0);
part_type_life(p1,15,30);

particles = [[dust, 100], [p1, 50]];

fallbreakSound = snd_pillowhit;

origLayer = layer;
depth += 10;