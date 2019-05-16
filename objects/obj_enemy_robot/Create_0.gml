event_inherited();
name = "Robot";
descriptionChoices = ["C3P0's Cranky Friend", "This is NOT the droid you're looking for", "Still more empathetic than my ex-wife"];
description = "C3P0's Cranky Friend";
spriteName = "robot";
spriteString = "enemy_robot";
isFairy = false;
isFloating = false;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = C_GOLD;
dyingParticleColor2 = c_ltgray;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 800;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [45,75];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [25,50];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 50;
cautiousness = 0;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 100;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)

// ATTACKS
global.owner = id;
var charge = makeEnemyAttackObj(obj_attack_robot_charge_1_1);
var laserbeam = makeEnemyAttackObj(obj_attack_robot_laser_1_1);

var chargeChain = [charge];
var laserChain = [laserbeam];
meleeAttacks = [laserChain, chargeChain];

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [];

hp = 75;
maxHp = 75;
hpRegen = 2;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 50;

ds_map_replace(defenses, MAGIC, -150);
ds_map_replace(defenses, ICE, -50);
ds_map_replace(defenses, FIRE, -50);
ds_map_replace(defenses, LIGHTNING, 100);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 12);
ds_map_replace(defenses, PIERCE, 15);
ds_map_replace(defenses, CRUSH, 5);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_robot_hit_1, snd_enemy_robot_hit_2, snd_enemy_robot_hit_3];
soundsWhenDie = [snd_enemy_robot_death_1, snd_enemy_robot_death_2, snd_enemy_robot_death_3, snd_enemy_robot_death_4, snd_enemy_robot_death_5];

chanceToDropHealthOrb = .3;

walkingSound = snd_robot_move;

soundsWhenHit = [snd_metalhit1, snd_metalhit2]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)