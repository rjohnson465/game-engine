if variable_global_exists("fromEnemyIndex") {
	owner = global.fromEnemyIndex;
	if instance_exists(owner) {
		layer = owner.layer;
	}
} 

soundCreate = snd_magic_magic_shoot;
audio_play_sound_at(soundCreate, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

isMoving = true;
moveDuration = 45;
moveSpeed = 4;
randomize();
moveDirection = random_range(0,360);

alarm[0] = moveDuration; // cannot be picked up for 45 seconds

// Floats
scale = 1;
floatingFrame = random_range(0,59); //0-60 "float" for fairies (grow/shrink)
rotAngle = random_range(0,360);
var c_pink = make_color_rgb(195,115,115);

// Light
var floorNum = getLayerFloorNumber(layer);
lightRadiusAlpha = calculateLightRadiusAlphaLayer(floorNum)*2;
if lightRadiusAlpha < .5 lightRadiusAlpha = .5;
lightRadiusScale = .5;
lightRadiusColor = c_pink;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,1,obj_light_radius);

// Particles
particle = noone;
system = part_system_create();
part_system_depth(system, depth+1);
emitter = part_emitter_create(system);
emitter2 = part_emitter_create(system);
var blood = part_type_create();
part_type_shape(blood, pt_shape_sphere);
part_type_color2(blood,c_maroon,c_red);
part_type_alpha3(blood, .5, .25, 0);
part_type_orientation(blood,0,0,0,15,1);
part_type_size(blood,0,0.15,0,0);
part_type_speed(blood,1,2,0,0);
part_type_direction(blood,0,360,0,4);
part_type_life(blood,20,30);
particle = blood;

var blood = part_type_create();
part_type_shape(blood, pt_shape_sphere);
part_type_color2(blood,c_maroon,c_pink);
part_type_orientation(blood,0,0,0,15,1);
part_type_alpha2(blood, 1, .15);
part_type_size(blood,0.05,0.15,0,0);
part_type_speed(blood,2,4,0,0);
part_type_direction(blood,0,360,0,4);
part_type_life(blood,25,33);
particle2 = blood;

soundPickup = snd_iu_healthorb;
soundIdle = snd_healthorb;

sndEmitter = audio_emitter_create();
audio_emitter_position(sndEmitter, x, y, depth);
audio_emitter_falloff(sndEmitter, 25, 300, 1);
sndEmitterSndId = audio_play_sound_on(sndEmitter, soundIdle, 1, 0);

// for particles
hasSetAlarm = false;

show_debug_message(sprite_index);