event_inherited();
name = "Sentient Gear";
descriptionChoices = ["One bad cog and it all goes kablooey", "(s) of War"];
description = "One bad cog and it all goes kablooey";
spriteName = "gear";
spriteString = "enemy_gear";
isFairy = false;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 6;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(103,95,78);
dyingParticleColor2 = c_ltgray;

canJump = false;

poiseCurrent = 28;
poiseMax = 28;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 800;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [60,90];
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
var throw = makeEnemyAttackObj(obj_attack_gear_throw_1_1);
var aoe = makeEnemyAttackObj(obj_attack_gear_aoe_1_1);

var tc = [throw];
var aoec = [aoe];
meleeAttacks = [tc, aoec];

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [tc];

hp = 75;
maxHp = 75;
hpRegen = 2;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 25;

ds_map_replace(defenses, MAGIC, -150);
ds_map_replace(defenses, ICE, -50);
ds_map_replace(defenses, FIRE, 0);
ds_map_replace(defenses, LIGHTNING, 50);
ds_map_replace(defenses, POISON, 100);
ds_map_replace(defenses, SLASH, 10);
ds_map_replace(defenses, PIERCE, 5);
ds_map_replace(defenses, CRUSH, 0);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_gear_hit_1, snd_enemy_gear_hit_2, snd_enemy_gear_hit_3, snd_enemy_gear_hit_4];
soundsWhenDie = [snd_enemy_gear_death_1, snd_enemy_gear_death_2];

chanceToDropHealthOrb = .3;

walkingSound = noone;

soundsWhenHit = [snd_metalhit1, snd_metalhit2]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)