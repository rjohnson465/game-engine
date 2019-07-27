event_inherited();
material = METAL;
origLayer = layer;
depth += 1; // hands appear over flower
stopsAttacks = false;

isActive = false;

index = image_index;

sprOn = spr_factory_pipe_on;
sprOff = spr_factory_pipe_off;

valve = noone; // valve object that controls this pipe

soundIndex = noone;
soundOn = snd_fountain_running;

pKey = noone;


system = part_system_create();
part_system_depth(system, depth + 1);

emitter = part_emitter_create(system);

// water particle
var water = part_type_create();
part_type_shape(water, pt_shape_sphere);
part_type_color2(water,c_aqua,c_white);
part_type_orientation(water,0,0,0,15,1);
part_type_size(water,0.06,0.1,0,0);
part_type_speed(water,1,2,0,0);
part_type_direction(water,0,360,0,4);
part_type_life(water,11,18);
part_type_alpha2(water, .8, .2);
particle = water;
