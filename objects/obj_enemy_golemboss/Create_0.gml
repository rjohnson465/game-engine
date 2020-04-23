event_inherited();
name = "Amir, Possessed Golem Lord";
descriptionChoices = ["C3P0's Cranky Friend", "This is NOT the droid you're looking for", "Still more empathetic than my ex-wife"];
description = "C3P0's Cranky Friend";
spriteName = "golemboss";
spriteString = "enemy_golemboss";
isFairy = false;
isFloating = false;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_olive;

cannotStagger = true;
poiseCurrent = 75;
poiseMax = 75;

sightAngleDelta = 360;


isBoss = true;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 2000;
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

xpReward = 0;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;
var stab = makeEnemyAttackObj(obj_attack_golemboss_stab_1_1);
var fb = makeEnemyAttackObj(obj_attack_golemboss_fireball_1_1);
var sswing = makeEnemyAttackObj(obj_attack_golemboss_slowswing_1_1);
var swing = makeEnemyAttackObj(obj_attack_golemboss_swing_1_1);
var fireblast = makeEnemyAttackObj(obj_attack_golemboss_fireblast_1_1);
var slam1 = makeEnemyAttackObj(obj_attack_golemboss_slam_1_1);
var slam2 = makeEnemyAttackObj(obj_attack_golemboss_slam_1_2);
var roll = makeEnemyAttackObj(obj_attack_golemboss_ball_1_1);
var mm = makeEnemyAttackObj(obj_attack_golemboss_mm_1_1);
var dybbuk = makeEnemyAttackObj(obj_attack_golemboss_dybbuk_1_1);

var c0 = [swing, stab, fb];
var c1 = [sswing];
var c2 = [fireblast, fireblast, fireblast];
var c3 = [slam1, slam2];
var c4 = [stab, fb];
var c5 = [roll];
var c6 = [swing, roll];
var c7 = [swing, stab, roll];
var c8 = [mm];
var c9 = [dybbuk];
// var c10 = [swing, mm];
// var c11 = [swing, dybbuk];
// var c12 = [swing, stab, mm];
// var c13 = [swing, fireblast];
var c14 = [stab, fireblast];
meleeAttacks = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c14];
// meleeAttacks = [c3];

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [];

hp = 400;
maxHp = 400;
hpRegen = 0;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, MAGIC, 15);
ds_map_replace(defenses, ICE, -25);
ds_map_replace(defenses, FIRE, 50);
ds_map_replace(defenses, LIGHTNING, -25);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 25);
ds_map_replace(defenses, PIERCE, 5);
ds_map_replace(defenses, CRUSH, 45);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

// soundsWhenHit = [snd_hit_rocky_2];
soundsWhenHitVocals = [snd_enemy_golem_roar_1, snd_enemy_golem_roar_2, snd_enemy_golem_roar_3];
soundsWhenDie = [snd_enemy_golem_die_1];

chanceToDropHealthOrb = 1;

walkingSound = snd_walking_heavy;

