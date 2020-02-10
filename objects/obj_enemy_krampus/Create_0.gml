event_inherited();
name = "Krampus";
descriptionChoices = ["Do not make him say 'Happy Holidays'", "Have a holly jolly Christmas, or else", "Ice Resistant"];
description = "Ice Resistant";
spriteName = "krampus";
spriteString = "enemy_krampus";
isFairy = true;
isFloating = true;

functionalSpeed = 6;
normalSpeed = 6;
turnSpeed = 10;
normalTurnSpeed = 10;

poiseCurrent = 50;
poiseMax = 50;

sightAngleDelta = 360;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

dyingParticleColor1 = [make_color_rgb(36,129,92), c_red];

// all weapons / shields enemy can use
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var kstaff = makeEnemyWeapon(obj_hand_item_krampusstaff);
ds_map_replace(handItems,"lm1",kstaff);
ds_map_replace(handItems,"rm1",kstaff);
// ds_map_replace(handItems,"lm2",unarmed);
// ds_map_replace(handItems,"rm2",unarmed);
ds_map_replace(handItems,"lr1",kstaff);
ds_map_replace(handItems,"rr1",unarmed);
rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",kstaff);
ds_map_replace(equippedLimbItems,"r",kstaff);

var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 400;
rangedAggroRange = 2000;
farthestAllowedFromPost = 2000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [30,45];
attackFrequencyTotalFramesRanged = [45,70];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 15;

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var swing1 = makeEnemyAttackObj(obj_attack_krampus_staff_1_1);
var stab12 = makeEnemyAttackObj(obj_attack_krampus_staff_1_2);
var swing12 = makeEnemyAttackObj(obj_attack_krampus_staff_1_3);

var stab1 = makeEnemyAttackObj(obj_attack_krampus_staff_2_1);
var iceburst = makeEnemyAttackObj(obj_attack_krampus_staff_3_1);
var icicleChunks = makeEnemyAttackObj(obj_attack_krampus_icechunks_1_1);

var summonElf = makeEnemyAttackObj(obj_attack_krampus_summon_1_1);

var c0 = [swing1];
var c1 = [swing1, stab12];
var c2 = [swing1, swing12];
var c3 = [stab1];
var c4 = [iceburst];
var c5 = [icicleChunks];
var c6 = [summonElf];
meleeAttacks = [c0, c1, c2, c3, c4, c5];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;

var icicleChunks = makeEnemyAttackObj(obj_attack_krampus_icechunks_1_1);

var c0 = [icicleChunks];
var c1 = [summonElf];

rangedAttacks = [c0, c1];
// rangedAttacks = [c1];


hp = 500;
maxHp = 500;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,50);
ds_map_replace(defenses,ICE,100);
ds_map_replace(defenses,FIRE,-50);

soundsWhenHitVocals = [snd_enemy_krampuself_hit_1, snd_enemy_krampuself_hit_2];
soundsWhenDie = [snd_enemy_krampuself_die_1];

isBoss = true;

xpReward = 1500;


// teleport 5-9 seconds after any damage taken
damageTaken = 0;
DAMAGE_TO_TELEPORT = 1;
TELEPORT_PREP_FRAME_MIN = 150;
TELEPORT_PREP_FRAME_MAX = 270;
TELEPORT_LAST_OBJ = instance_nearest(x, y, obj_teleport_point);
eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_dybukkboss_teleport_on_damage);

chanceToDropHealthOrb = 1;



