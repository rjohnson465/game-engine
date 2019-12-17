event_inherited();
name = "Ravebot";
descriptionChoices = ["C3P0's Cranky Friend", "This is NOT the droid you're looking for", "Still more empathetic than my ex-wife"];
description = "C3P0's Cranky Friend";
spriteName = "ravebot";
spriteString = "enemy_ravebot";
isFairy = false;
isFloating = false;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = [make_color_rgb(163,255,109), make_color_rgb(255,122,228), make_color_rgb(109,255,210), make_color_rgb(0,75,255) ];

poiseCurrent = 75;
poiseMax = 75;

sightAngleDelta = 360;

// try summon every 10-15 seconds
SUMMON_FREQ_MIN = 300; SUMMON_FREQ_MAX = 450;
summonFrequencyFramesRange = [SUMMON_FREQ_MIN, SUMMON_FREQ_MAX];
randomize();
summonFrame = random_range(300, SUMMON_FREQ_MAX);

summonParticle1 = part_type_create();
part_type_shape(summonParticle1, pt_shape_sphere);
part_type_alpha2(summonParticle1,1,.2);
part_type_color2(summonParticle1,make_color_rgb(163,255,109),c_white);
part_type_size(summonParticle1,.05,.15,0,0);
part_type_speed(summonParticle1,.5,2,0,0);
part_type_direction(summonParticle1,0,360,0,4); // set later
part_type_orientation(summonParticle1,0,360,5,5,1);
part_type_life(summonParticle1,15,25);
summonParticle2 = part_type_create();
part_type_shape(summonParticle2, pt_shape_sphere);
part_type_alpha2(summonParticle2,1,.2);
part_type_color2(summonParticle2,make_color_rgb(255,122,228),c_white);
part_type_size(summonParticle2,.05,.15,0,0);
part_type_speed(summonParticle2,.5,2,0,0);
part_type_direction(summonParticle2,0,360,0,4); // set later
part_type_orientation(summonParticle2,0,360,5,5,1);
part_type_life(summonParticle2,15,25);

summonPartSystem = part_system_create();
summonPartEmitter = part_emitter_create(summonPartSystem);


isBoss = true;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 800;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [45,60];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [25,50];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 50;
cautiousness = 0;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 1245;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;
var charge = makeEnemyAttackObj(obj_attack_ravebot_charge_1_1);
var laserbeam = makeEnemyAttackObj(obj_attack_ravebot_laser_1_1);

var d11 = makeEnemyAttackObj(obj_attack_ravebot_dance_1_1);
var d12 = makeEnemyAttackObj(obj_attack_ravebot_dance_1_2);
var d13 = makeEnemyAttackObj(obj_attack_ravebot_dance_1_3);
var d14 = makeEnemyAttackObj(obj_attack_ravebot_dance_1_4);

var d21 = makeEnemyAttackObj(obj_attack_ravebot_dance_2_1);
var d22 = makeEnemyAttackObj(obj_attack_ravebot_dance_2_2);

var l11 = makeEnemyAttackObj(obj_attack_ravebot_laserbolt_1_1);
var l12 = makeEnemyAttackObj(obj_attack_ravebot_laserbolt_1_2);

var chargeChain = [charge];
var chargeChain2 = [charge, charge, charge];
var laserChain = [laserbeam];
var dance1Chain = [d11, d12, d13, d14];
var dance2Chain = [d21, d22];
var lbChain = [l11, l12, l12, l12];

meleeAttacks = [lbChain, laserChain, chargeChain, dance1Chain, dance2Chain, chargeChain2];

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [];

hp = 275;
maxHp = 275;
hpRegen = .66;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 50;

ds_map_replace(defenses, MAGIC, -75);
ds_map_replace(defenses, ICE, -10);
ds_map_replace(defenses, FIRE, -10);
ds_map_replace(defenses, LIGHTNING, 100);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 25);
ds_map_replace(defenses, PIERCE, 35);
ds_map_replace(defenses, CRUSH, 20);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_robot_hit_1, snd_enemy_robot_hit_2, snd_enemy_robot_hit_3];
soundsWhenDie = [snd_enemy_robot_death_1, snd_enemy_robot_death_2, snd_enemy_robot_death_3, snd_enemy_robot_death_4, snd_enemy_robot_death_5];

chanceToDropHealthOrb = 1;

walkingSound = snd_robot_move;

soundsWhenHit = [snd_metalhit1, snd_metalhit2]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)