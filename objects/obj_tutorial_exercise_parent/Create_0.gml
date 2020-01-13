event_inherited();

visible = false;

exerciseName = "Default Exercise Name";
exerciseSteps = ds_list_create();
currentExerciseStep = noone;
currentExerciseStep = noone;
isActive = false;
isFinished = false;

// while exercise is active, associated walls are active
hasActivatedWalls = false;
associatedWallKeys = noone;

part = part_type_create();
system = part_system_create();
part_system_depth(system, -1000);
emitter = part_emitter_create(system);
part_system_automatic_draw(system, false);
part_emitter_region(system, emitter, -100, -100, -100, -100, ps_shape_ellipse, ps_distr_linear);
partRegionPrevX = noone;
partRegionPrevY = noone;
doNotShowParticles = false;

isShowingAMessage = false;

var fire = part_type_create();
part_type_sprite(fire,spr_particle_fire,0,0,1);
part_type_size(fire,.2,.5,0,0);
part_type_color2(fire,c_aqua,c_silver);
part_type_alpha3(fire,.75,.5,0);
part_type_speed(fire,2,5,0,0);
part_type_direction(fire,0,360,0,5);
part_type_orientation(fire,0,359,0,0,0);
part_type_blend(fire,1);
part_type_life(fire,15,25);
part = fire;