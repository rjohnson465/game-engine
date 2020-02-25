event_inherited();

isActive = false;
material = METAL;

isNonPriorityInteractable = true;

hp = 100;

isAwakening = false;
isSurrendering = false;
isGoingToAri = false;
isWithAri = false;

gridPath = path_add();
isPathSet = false;
grid = noone;

walkingSoundIndex = noone;
walkingEmitter = audio_emitter_create();

isObstacleOnGrid = false;

system = part_system_create();
part_system_depth(system,layer_get_depth(layer)-5);
emitter = part_emitter_create(system);
particle = part_type_create();
part_type_sprite(particle, spr_particle_heart, 0, 0, 0);
part_type_color2(particle, c_red, c_silver);
part_type_direction(particle, 45, 135, 0, 1);
part_type_life(particle, 30, 60);
part_type_size(particle, .2, .25, 0, 0);
part_type_alpha2(particle, .65, .2);
part_type_speed(particle, .2, .3, 0, 0);