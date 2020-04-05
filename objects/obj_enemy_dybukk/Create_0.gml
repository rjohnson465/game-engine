event_inherited();
isShowingGrid = false;
name = "Dybukk";
descriptionChoices = ["One spooky boy", "Likes getting into clay men", "Physical resistant"];
description = "One spooky boy";
spriteName = "dybukk";
spriteString = "enemy_dybukk";
isFairy = false;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 10;
normalTurnSpeed = turnSpeed;

isLightRadiusAlwaysOn = true;
lightRadiusAlpha = .25;
lightRadiusColor = make_color_rgb(33,180,154);
calculatesLightRadiusOnRoomStart = false;
isLightRadiusAlphaFixed = true;

dyingParticleColor1 = make_color_rgb(33,180,154);
dyingParticleColor2 = c_silver;

canJump = true;


hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 250;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [45,70];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

poiseCurrent = 30;
poiseMax = 30;
poiseRegen = 2;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 125;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS
global.owner = id;
var slash1 = makeEnemyAttackObj(obj_attack_dybukk_slash_1_1);
var slash2 = makeEnemyAttackObj(obj_attack_dybukk_slash_1_2);
var headthrowmelee = makeEnemyAttackObj(obj_attack_dybukk_headthrow_melee_1_1);

var c0 = [slash1];
var c1 = [headthrowmelee];
var c2 = [slash1, slash2];
meleeAttacks = [c0, c1, c2];
// meleeAttacks = [c2];

// ranged attacks info
var headthrow = makeEnemyAttackObj(obj_attack_dybukk_headthrow_1_1);

var c0 = [headthrow];
rangedAttacks = [c0];


hp = 75;
maxHp = 75;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)



ds_map_replace(defenses, SLASH, 25);
ds_map_replace(defenses, PIERCE, 25);
ds_map_replace(defenses, CRUSH, 25);

ds_map_replace(defenses, MAGIC, -50);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_dybukk_scream_2, snd_enemy_dybukk_scream_3];
soundsWhenDie = [snd_enemy_dybukk_die_1, snd_enemy_dybukk_die_2];

chanceToDropHealthOrb = .15;

// constant emitter / ps for "spore" trails
sporeSystem = part_system_create();
sporeEmitter = part_emitter_create(sporeSystem);
// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,make_color_rgb(33,180,154),c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
sporeParticle = smoke;

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_sphere);
part_type_color2(smoke,c_aqua,c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.1,0.3,0,0);
part_type_speed(smoke,3,6,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
possessParticle = smoke;

part_system_depth(sporeSystem, layer_get_depth(layer)+1);

isAggroed = true;

// maybe
beamLight = instance_create_layer(x, y, layer, obj_dybukk_beamlight);
if instance_exists(beamLight) {
	beamLight.x = -1000; beamLight.y = -1000;
}