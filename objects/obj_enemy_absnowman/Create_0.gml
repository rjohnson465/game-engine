event_inherited();
name = "The Abominable Snowman";
descriptionChoices = ["C3P0's Cranky Friend", "This is NOT the droid you're looking for", "Still more empathetic than my ex-wife"];
description = "C3P0's Cranky Friend";
spriteName = "absnowman";
spriteString = "enemy_absnowman";
isFairy = false;
isFloating = false;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = c_white;
dyingParticleColor2 = c_purple;

cannotStagger = true;
poiseCurrent = 75;
poiseMax = 75;

sightAngleDelta = 360;


isBoss = true;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 800;
rangedAggroRange = 2500;
farthestAllowedFromPost = 2800;
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

xpReward = 3000;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;
var sb11 = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_1_melee);
var sb12 = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_2_melee);

var sb21 = makeEnemyAttackObj(obj_attack_absnowman_snowball_2_1_melee);

var swing11 = makeEnemyAttackObj(obj_attack_absnowman_swing_1_1);
var swing12 = makeEnemyAttackObj(obj_attack_absnowman_swing_1_2);
var swing21 = makeEnemyAttackObj(obj_attack_absnowman_swing_2_1);
var fallAttack = makeEnemyAttackObj(obj_attack_absnowman_fall_1_1);

var slam11 = makeEnemyAttackObj(obj_attack_absnowman_slam_1_1);
var slam12 = makeEnemyAttackObj(obj_attack_absnowman_slam_1_2)

var slam21 = makeEnemyAttackObj(obj_attack_absnowman_slam_2_1);

var charge = makeEnemyAttackObj(obj_attack_absnowman_charge_1_1);
var charge12 = makeEnemyAttackObj(obj_attack_absnowman_charge_1_2);

var c0 = [sb11, sb12];
var c1 = [sb21];
var c2 = [swing11, fallAttack];
var c3 = [charge, charge12, charge12];
var c4 = [slam11, slam12];
var c5 = [slam21];
var c6 = [swing11, swing12];
var c7 = [swing11, slam12];
var c8 = [swing11, swing12, slam11];
var c9 = [slam11, swing12, fallAttack];
var c10 = [sb11, sb12, sb21];
var c11 = [sb21, fallAttack, charge12];
var c12 = [swing21];
meleeAttacks = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11];
meleeAttacks = [c12];

// ranged attacks info

// currently chosen ranged attack
var sb11r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_1);
var sb12r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_2);
var sb21r = makeEnemyAttackObj(obj_attack_absnowman_snowball_2_1);

var r0 = [sb11r, sb12r];
var r1 = [sb21r];
rangedAttacks = [r0, r1];

hp = 600;
maxHp = 600;
hpRegen = 0;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, MAGIC, 15);
ds_map_replace(defenses, ICE, 100);
ds_map_replace(defenses, FIRE, -50);
ds_map_replace(defenses, LIGHTNING, -25);
ds_map_replace(defenses, POISON, 0);
ds_map_replace(defenses, SLASH, 45);
ds_map_replace(defenses, PIERCE, 25);
ds_map_replace(defenses, CRUSH, 35);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

// soundsWhenHit = [snd_hit_rocky_2];
soundsWhenHitVocals = [snd_enemy_golem_roar_1, snd_enemy_golem_roar_2, snd_enemy_golem_roar_3];
soundsWhenDie = [snd_enemy_golem_die_1];

chanceToDropHealthOrb = 1;

walkingSound = snd_walking_heavy;

