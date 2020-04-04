event_inherited();
isShowingGrid = false;
name = "Possessed Golem";
descriptionChoices = ["Failed pottery experiment", "Big clay man", "Poison Resistant"];
description = "Failed pottery experiment";
spriteName = "golem";
spriteString = "enemy_golem";
isFairy = false;
isFloating = false;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 5;
normalTurnSpeed = turnSpeed;


dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_olive;

canJump = true;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 250;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [20,45];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

poiseCurrent = 10000;
poiseMax = 10000;
poiseRegen = 100;
cannotStagger = true;

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
var slam = makeEnemyAttackObj(obj_attack_golem_slam_1_1);
var swing1 = makeEnemyAttackObj(obj_attack_golem_swing_1_1);
var swing2 = makeEnemyAttackObj(obj_attack_golem_swing_1_2);
var ball = makeEnemyAttackObj(obj_attack_golem_ball_1_1);

var c0 = [slam];
var c1 = [swing1];
var c2 = [swing1, swing2];
var c3 = [ball];
var c4 = [swing1, slam];
var c5 = [swing1, swing2, slam];
meleeAttacks = [c0, c1, c2, c3, c4, c5, c2];

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



ds_map_replace(defenses, POISON, 90);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

// soundsWhenHit = [snd_hit_rocky_2];
soundsWhenHitVocals = [snd_enemy_golem_roar_1, snd_enemy_golem_roar_2, snd_enemy_golem_roar_3];
soundsWhenDie = [snd_enemy_golem_die_1];

chanceToDropHealthOrb = .2;

walkingSound = snd_walking_heavy;
