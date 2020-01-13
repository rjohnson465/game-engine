event_inherited();
isShowingGrid = false;
name = "Ice Wyrm";
descriptionChoices = ["Ice Resistant", "Weak to fire", "Burrows"];
description = "Burrows";
spriteName = "icewyrm";
spriteString = "enemy_icewyrm";
isFairy = false;
isFloating = false;

functionalSpeed = 7;
normalSpeed = 7;
turnSpeed = 15;
normalTurnSpeed = turnSpeed;

dyingParticleColor1 = make_color_rgb(42,67,90);
dyingParticleColor2 = make_color_rgb(54,99,141);

canJump = true;

// canStrafe = false;

hasHands = false; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// general attacks info
meleeAggroRange = 500;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [20,45];
attackFrequencyTotalFramesRanged = [15,30];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 0;
cautiousness = 0;

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

var bite = makeEnemyAttackObj(obj_attack_icewyrm_bite_1_1);
var spray = makeEnemyAttackObj(obj_attack_icewyrm_spray_1_1);
var snowball = makeEnemyAttackObj(obj_attack_icewyrm_snowball_1_1);
var c2 = [snowball];
var c0 = [bite];
var c1 = [spray];
meleeAttacks = [c0, c1, c2];

// ranged attacks info
rangedAttacks = [c2];


hp = 75;
maxHp = 75;
hpRegen = 1;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

ds_map_replace(defenses, FIRE, -100);
ds_map_replace(defenses, ICE, 75);

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

soundsWhenHitVocals = [snd_enemy_icewyrm_hit_1, snd_enemy_icewyrm_hit_2];
soundsWhenDie = [snd_enemy_icewyrm_die_1];

chanceToDropHealthOrb = .1;

walkingSound = snd_icewyrm_burrow;

canFlinch = false;
canStrafe = false;
staggerSpeed = 0;

// burrowing
canBurrow = false;
isBurrowing = false;
BURROW_FRAMES_FREQ_MIN = 90;
BURROW_FRAMES_FREQ_MAX = 150;
BURROW_FRAMES = 200;
burrowFrame = noone;
randomize();
var bFrames = random_range(BURROW_FRAMES_FREQ_MIN, BURROW_FRAMES_FREQ_MAX);
alarm[4] = bFrames;
var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.1,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_alpha3(snowflake,1,.75,.5);
part_type_color2(snowflake, c_navy, c_aqua);
burrowParticle = snowflake;
part_system_depth(sprintParticleSystem, depth-1);
normalSpriteIndex = sprite_index;
