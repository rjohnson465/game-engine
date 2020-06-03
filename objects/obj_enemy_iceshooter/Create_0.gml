event_inherited();
isShowingGrid = false;
name = "Dark Winter Ice";
descriptionChoices = ["Weak to fire"];
description = "Weak to fire";
spriteName = "iceshooter";
spriteString = "enemy_iceshooter";
isFairy = false;
isFloating = true;

functionalSpeed = 0;
normalSpeed = 0;
turnSpeed = 0;
normalTurnSpeed = turnSpeed;

sightAngleDelta = 359;

dyingParticleColor1 = c_aqua;
dyingParticleColor2 = c_purple;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 0;
rangedAggroRange = 800;
farthestAllowedFromPost = 100;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [60,90];
attackFrequencyTotalFramesMeleeDefault = [90, 90];
attackFrequencyTotalFramesRanged = [90,90];
attackFrequencyTotalFramesRangedDefault = [90, 90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[15,60];
skittishness = 100;
cautiousness = 75;

poiseCurrent = 25;
poiseMax = 25;
cannotStagger = true;
canFlinch = false;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 1;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS
meleeAttacks = [];

// ranged attacks info
global.owner = id;
var fb = makeEnemyAttackObj(obj_attack_iceshooter_shoot_1_1);
var c0 = [fb];
rangedAttacks = [c0];


hp = 50;
maxHp = 50;
hpRegen = 0;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, FIRE, -100);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 100);
ds_map_replace(defenses, PIERCE, 100);
ds_map_replace(defenses, CRUSH, 100);
ds_map_replace(defenses, MAGIC, 100);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHit = [snd_hit_ice_2, snd_hit_ice_3, snd_hit_ice_4];
soundsWhenHitVocals = [snd_hit_rocky_1];
soundsWhenDie = [];

chanceToDropHealthOrb = 1;

// constant emitter / ps for "spore" trails
sporeSystem = part_system_create();
sporeEmitter = part_emitter_create(sporeSystem);
// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_aqua, c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
sporeParticle = smoke;
part_system_depth(sporeSystem, layer_get_depth(layer)+1);

isLightRadiusAlwaysOn = true;
lightRadiusAlpha = .5;
lightRadiusColor = make_color_rgb(33,180,154);
calculatesLightRadiusOnRoomStart = false;
isLightRadiusAlphaFixed = true;


refreshCombatantsHit = 25;

isMinion = false;