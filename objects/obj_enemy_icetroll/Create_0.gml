event_inherited();
isShowingGrid = false;
name = "Ice Troll";
descriptionChoices = ["Rawr", "No problem, brother, stay frosty", "Weak to fire", "Ice resistant", "Speak loudly and carry a big stick"];
description = "Weak to fire";
spriteName = "icetroll";
spriteString = "enemy_icetroll";
isFairy = false;
isFloating = false;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 7;
normalTurnSpeed = turnSpeed;


dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_aqua;

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

poiseCurrent = 125;
poiseMax = 125;
poiseRegen = 2;
cannotStagger = false;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 400;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var club1 = makeEnemyAttackObj(obj_attack_icetroll_club_1_1);
var slam1 = makeEnemyAttackObj(obj_attack_icetroll_slam_1_1);
var slam2 = makeEnemyAttackObj(obj_attack_icetroll_slam_1_2);
var drag = makeEnemyAttackObj(obj_attack_icetroll_drag_1_1);
var punch = makeEnemyAttackObj(obj_attack_icetroll_punch_1_1);

var c0 = [club1];
var c1 = [slam1];
var c2 = [slam1, slam2];
var c3 = [slam1, drag];
var c4 = [club1, punch];
meleeAttacks = [c0, c1, c2, c3, c4];
// meleeAttacks = [c3];

// ranged attacks info

rangedAttacks = [];


hp = 250;
maxHp = 250;
hpRegen = 2;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)


ds_map_replace(defenses, ICE, 90);
ds_map_replace(defenses, FIRE, -75);
ds_map_replace(defenses, CRUSH, 40);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_troll_hit_1, snd_enemy_troll_hit_2, snd_enemy_troll_hit_3];
soundsWhenDie = [snd_enemy_troll_die_1];

chanceToDropHealthOrb = 1;

walkingSound = snd_walking_heavy;
