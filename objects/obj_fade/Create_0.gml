fadeDuration = global.fadeDuration;
owner = global.owner;
frame = 0;
emitter = noone;
system = noone;
particle = noone;
depth = -10000;
// fountains create water particles everywhere over fade
if owner.object_index == obj_fountain {
	system = part_system_create();
	part_system_depth(system,depth-1);
	emitter = part_emitter_create(system);
	
	// water particle
	var water = part_type_create();
	part_type_shape(water, pt_shape_sphere);
	part_type_color2(water,c_aqua,c_ltgray);
	part_type_orientation(water,0,0,0,15,1);
	part_type_size(water,.2,.5,0,0);
	part_type_speed(water,2,3,0,0);
	part_type_direction(water,0,360,0,4);
	part_type_life(water,7,11);
	particle = water;
}

hasSetAlarm = false;