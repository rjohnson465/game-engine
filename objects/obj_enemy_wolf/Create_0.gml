event_inherited();
isShowingGrid = false;
name = "Arctic Wolf";
descriptionChoices = ["Good doggy?", "Things are about to get ruff"];
description = "Good doggy?";
spriteName = "wolf";
spriteString = "enemy_wolf";
isFairy = false;
isFloating = false;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 5;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = c_silver;
dyingParticleColor2 = c_olive;

canJump = true;

canStrafe = false;

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

poiseCurrent = 25;
poiseMax = 25;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 80;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var lunge = makeEnemyAttackObj(obj_attack_wolf_lunge_1_1);

var c_lunge = [lunge];
meleeAttacks = [c_lunge];

// ranged attacks info

rangedAttacks = [];


hp = 35;
maxHp = 35;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 80;

ds_map_replace(defenses, FIRE, -100);
ds_map_replace(defenses, ICE, 75);

// dodge stuff
agility = 20; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_wolf_hit_1, snd_enemy_wolf_hit_2, snd_enemy_wolf_hit_3];
soundsWhenDie = [snd_enemy_wolf_die_1, snd_enemy_wolf_die_2];

chanceToDropHealthOrb = .1;

walkingSound = snd_walking_galloping_snow;
