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

var c_slam = [slam];
meleeAttacks = [c_slam];

// ranged attacks info

rangedAttacks = [];


hp = 100;
maxHp = 100;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)



ds_map_replace(defenses, POISON, 90);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [];
soundsWhenDie = [];

chanceToDropHealthOrb = .2;

walkingSound = snd_walking_heavy;
