event_inherited();
isShowingGrid = false;
name = "Gargoyle Bust";
descriptionChoices = ["Poison Resistant", "Fire Resistant", "Slash / Pierce Resistant", "Weak to magic", "Definitely just a statue"];
description = "Definitely just a statue";
spriteName = "gargoylebust";
spriteString = "enemy_gargoylebust";
isFairy = false;
isFloating = false;

functionalSpeed = 0;
normalSpeed = 0;
turnSpeed = 0;
normalTurnSpeed = turnSpeed;

sightAngleDelta = 355;

dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_olive;

canJump = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 0;
rangedAggroRange = 800;
farthestAllowedFromPost = 100;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [15,25];
attackFrequencyTotalFramesRanged = [65,90];
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

xpReward = 95;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS
meleeAttacks = [];

// ranged attacks info
global.owner = id;
var fb = makeEnemyAttackObj(obj_attack_gargoylebust_fireball_1_1);
var c0 = [fb];
rangedAttacks = [c0];


hp = 50;
maxHp = 50;
hpRegen = 0;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, FIRE, 100);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 35);
ds_map_replace(defenses, PIERCE, 35);
ds_map_replace(defenses, MAGIC, -100);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHit = [snd_hit_clay_1, snd_hit_clay_2];
soundsWhenHitVocals = [snd_hit_rocky_1];
soundsWhenDie = [];

chanceToDropHealthOrb = .2;