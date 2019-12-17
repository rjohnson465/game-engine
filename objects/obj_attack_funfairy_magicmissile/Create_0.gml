owner = global.owner;
life = 60;
depth = 1;
layer = owner.layer;
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
limbKey = global.limbKey; // l | r is most common
isSpell = true;
isRanged = true; // probably
attackData = global.attackData;
combatantsHit = ds_list_create();
hasSetAlarm = false;
additionalDamages = ds_map_create();
attackNumber = 3;
attackNumberInChain = 1;

particle = noone;
particle2 = noone;
percentCharged = 1;
system = part_system_create();
part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);
soundEmitter = audio_emitter_create();
audio_emitter_gain(soundEmitter, .5);
audio_play_sound_on(soundEmitter, snd_magic_magic_loop, 1, 0);
isSoundLooping = false;

sprite_index = spr_enemy_funfairy_toyhammer_attack_3_1;
damages = attackData.damages;
speed = attackData.projectileSpeed;
image_alpha = .5;
	
var startPos = rotateAndTranslatePoint(x, y, 50, 0, owner.facingDirection);
x = startPos[0]; y = startPos[1];
	
// particles
num = random_range(10,15);
// magic particle
var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_aqua,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0,0.07,0,0);
part_type_speed(magic,2,8,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);
particle = magic;
	
// spells have light radii
isSoundLooping = true;
lightRadius = 256;
var floorNum = getLayerFloorNumber(layer);
lightRadiusAlpha = calculateLightRadiusAlphaLayer(floorNum);
if lightRadiusAlpha <=.01 {
	lightRadiusAlpha = .3;
}
lightRadiusScale = .15;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
instance_create_depth(x,y,1,obj_light_radius);

audio_play_sound_at(snd_magic_magic_shoot, x, y, depth, 500, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

// let the funfairy carry on after shooting the missile
direction = owner.facingDirection;

facingDirection = direction; // facingDirection property needed for is_facing script
// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
// set recoverFrames to -1
ds_map_replace(owner.recoverFrames,limbKey,-1);
		
// remove limbKey from attackingLimbs map
ds_map_delete(owner.attackingLimbs,limbKey);

owner.prevAttackHand = limbKey;

isTracking = true;


