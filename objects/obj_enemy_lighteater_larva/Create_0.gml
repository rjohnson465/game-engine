event_inherited();
isShowingGrid = false;
name = "Lighteater Larva";
descriptionChoices = ["Are you scared of the dark?", "Good heavens, where's it's mother?", "It's a slug! It's a lobster! It's...??"];
description = "Good heavens, where's it's mother?";
spriteName = "lighteater_larva";
spriteString = "enemy_lighteater_larva";
isFairy = false;
isFloating = false;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 5;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = [make_color_rgb(143, 154, 136), make_color_rgb(87,96,80), make_color_rgb(100, 111, 77)];

canJump = false;

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

poiseCurrent = 15;
poiseMax = 15;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 12;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;


global.owner = id;
var a = makeEnemyAttackObj(obj_attack_lighteater_larva_lunge_1_1);

var c1 = [a];
meleeAttacks = [c1];
// meleeAttacks = [webAoeChain];

// ranged attacks info

// currently chosen ranged attack
rangedAttacks = [];


hp = 20;
maxHp = 20;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 75;

ds_map_replace(defenses, FIRE, -100);

// dodge stuff
agility = 45; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_speyeder_hit_1, snd_enemy_speyeder_hit_2];
soundsWhenDie = [snd_enemy_speyeder_death];

chanceToDropHealthOrb = .05;