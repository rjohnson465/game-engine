particle = noone;
system = part_system_create();
emitter = part_emitter_create(system);
var p = global.player;
part_emitter_region(system, emitter, p.x, p.x, p.y, p.y, ps_shape_ellipse, ps_distr_gaussian);
part_system_depth(system, p.depth+1);
var blood = part_type_create();
part_type_shape(blood, pt_shape_sphere);
part_type_color2(blood,c_maroon,c_red);
part_type_orientation(blood,0,0,0,15,1);
part_type_size(blood,0,0.15,0,0);
part_type_speed(blood,2,4,0,0);
part_type_direction(blood,0,360,0,4);
part_type_life(blood,10,15);
particle = blood;

hasSetAlarm = false;
alarm[1] = 15; // 15 seconds of particle generation