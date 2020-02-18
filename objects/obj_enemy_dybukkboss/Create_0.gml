event_inherited();
isShowingGrid = false;
name = "Insatiable Dybukk King";
descriptionChoices = ["One spooky boy", "Likes getting into clay men", "Physical resistant"];
description = "One spooky boy";
spriteName = "dybukkboss";
spriteString = "enemy_dybukkboss";
isFairy = false;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 10;
normalTurnSpeed = turnSpeed;


dyingParticleColor1 = c_red;
dyingParticleColor2 = c_silver;

isBoss = true;

canJump = true;


hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 250;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [45,70];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

poiseCurrent = 50;
poiseMax = 50;
poiseRegen = 2;

// melee attacks info
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];

xpReward = 1800;

// ATTACKS

// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
// ATTACKS


global.owner = id;
var beam = makeEnemyAttackObj(obj_attack_dybukkboss_beam);
var c0 = [beam];

meleeAttacks = [c0];

// ranged attacks info

rangedAttacks = [];


hp = 3;
maxHp = 3;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, SLASH, 25);
ds_map_replace(defenses, PIERCE, 25);
ds_map_replace(defenses, CRUSH, 25);
ds_map_replace(defenses, MAGIC, 50);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_dybukk_scream_2, snd_enemy_dybukk_scream_3];
soundsWhenDie = [snd_enemy_dybukk_die_1, snd_enemy_dybukk_die_2];

chanceToDropHealthOrb = 1;

hasRevivedGolem = false;

// teleport after x damage taken
damageTaken = 0;
DAMAGE_TO_TELEPORT = 50;
TELEPORT_PREP_FRAME_MIN = 90;
TELEPORT_PREP_FRAME_MAX = 150;
eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_dybukkboss_teleport_on_damage);
ds_map_add(eventListeners, EV_DARK_FOUNTAIN_WISH, scr_evl_dybukboss_remove);