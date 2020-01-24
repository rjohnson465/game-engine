event_inherited();
name = "Krampus Elf";
descriptionChoices = ["Do not make him say 'Happy Holidays'", "Have a holly jolly Christmas, or else", "Ice Resistant"];
description = "Ice Resistant";
spriteName = "krampuself";
spriteString = "enemy_krampuself";
isFairy = true;
isFloating = true;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 10;
normalTurnSpeed = 10;

poiseCurrent = 20;
poiseMax = 20;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

dyingParticleColor1 = [make_color_rgb(36,129,92), c_red];

// all weapons / shields enemy can use

var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);

var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
var icespear = makeEnemyWeapon(obj_hand_item_icespear, true);

ds_map_add(handItems,"lm1",icespear);
ds_map_add(handItems,"rm1",iceshield);

ds_map_replace(equippedLimbItems,"l",iceshield);
ds_map_replace(equippedLimbItems,"r",icespear);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 1500;
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

var heavyStab = makeEnemyAttackObj(obj_attack_krampuself_icespear_1_1);

var spearCharge = makeEnemyAttackObj(obj_attack_krampuself_icespear_2_1);

var jab1 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_1);
var jab2 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_2);
var jab3 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_3);

var c0 = [heavyStab];
var c1 = [spearCharge];
var c2 = [jab1, jab2, jab3];
meleeAttacks = [c0, c1, c2];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;


rangedAttacks = [];


hp = 100;
maxHp = 100;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 50;

// dodge stuff
agility = 40; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,40);
ds_map_replace(defenses,ICE,90);

soundsWhenHitVocals = [snd_enemy_krampuself_hit_1, snd_enemy_krampuself_hit_2];
soundsWhenDie = [snd_enemy_krampuself_die_1];

xpReward = 50;






