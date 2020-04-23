event_inherited();
isShowingGrid = false;
name = "Insatiable Dybukk King";
descriptionChoices = ["One spooky boy", "Likes getting into clay men", "Physical resistant"];
description = "One spooky boy";
spriteName = "dybukkboss";
spriteString = "enemy_dybukkboss";
isFairy = false;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 10;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = c_red;
dyingParticleColor2 = c_silver;

isBoss = true;

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

poiseCurrent = 50;
poiseMax = 50;
poiseRegen = 3;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 1500;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var beam = makeEnemyAttackObj(obj_attack_dybukkboss_beam);
var d1 = makeEnemyAttackObj(obj_attack_dybukkboss_dismantle_1_1);
var d2 = makeEnemyAttackObj(obj_attack_dybukkboss_dismantle_1_2);
var d3 = makeEnemyAttackObj(obj_attack_dybukkboss_dismantle_1_3);

var s1 = makeEnemyAttackObj(obj_attack_dybukkboss_servant_1_1);
var s2 = makeEnemyAttackObj(obj_attack_dybukkboss_servant_1_2);

var slash11 = makeEnemyAttackObj(obj_attack_dybukkboss_slash_1_1);
var slash12 = makeEnemyAttackObj(obj_attack_dybukkboss_slash_1_2);

// var c0 = [beam];
var c1 = [d1, d2, d3];
// var c2 = [s1, s2, s2];
// var c3 = [s1];
var c4 = [slash11, slash12];
var c5 = [s1, s2];
var c6 = [slash11, slash12];
var c7 = [slash11];

meleeAttacks = [c1, c4, c5, c6, c7];
// meleeAttacks = [c4, c6];
// ranged attacks info

rangedAttacks = [];


hp = 125;
maxHp = 125;
hpRegen = .5;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, SLASH, 35);
ds_map_replace(defenses, PIERCE, 35);
ds_map_replace(defenses, CRUSH, 35);
ds_map_replace(defenses, MAGIC, 50);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_dybukk_scream_2, snd_enemy_dybukk_scream_3];
soundsWhenDie = [snd_enemy_dybukk_die_1, snd_enemy_dybukk_die_2];

chanceToDropHealthOrb = 1;

hasRevivedGolem = false;

// teleport after x damage taken
damageTaken = 0;
DAMAGE_TO_TELEPORT = 10;
TELEPORT_PREP_FRAME_MIN = 60;
TELEPORT_PREP_FRAME_MAX = 120;
eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_dybukkboss_teleport_on_damage);
ds_map_add(eventListeners, EV_DARK_FOUNTAIN_WISH, scr_evl_dybukboss_remove);



// constant emitter / ps for "spore" trails
sporeSystem = part_system_create();
sporeEmitter = part_emitter_create(sporeSystem);
// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_red, c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
sporeParticle = smoke;
part_system_depth(sporeSystem, layer_get_depth(layer)+1);

isLightRadiusAlwaysOn = true;
lightRadiusAlpha = .35;
lightRadiusColor = c_red;
calculatesLightRadiusOnRoomStart = false;
isLightRadiusAlphaFixed = true;