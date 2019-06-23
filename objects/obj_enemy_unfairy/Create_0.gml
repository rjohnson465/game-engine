event_inherited();
name = "Unfairy";
descriptionChoices = ["Magic Resistant", "It'd' be unfair to call them fairies", "Life is unfairy", "Allergic to death", "Definitely evil being"];
description = "Magic Resistant";
spriteName = "unfairy";
spriteString = "enemy_unfairy";
isFairy = true;
isFloating = true;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 10;
normalTurnSpeed = 10;

poiseCurrent = 15;
poiseMax = 15;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use

var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);

var woodshield = makeEnemyWeapon(obj_hand_item_woodshield);
var longsword = makeEnemyWeapon(obj_hand_item_longsword, true);
var shortbow = makeEnemyWeapon(obj_hand_item_shortbow);

ds_map_add(handItems,"lm1",longsword);
ds_map_add(handItems,"rm1",woodshield);
ds_map_add(handItems, "lr1",shortbow);
ds_map_add(handItems, "rr1", unarmed);

ds_map_replace(equippedLimbItems,"l",woodshield);
ds_map_replace(equippedLimbItems,"r",longsword);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 300;
rangedAggroRange = 800;
farthestAllowedFromPost = 1000;
aggressiveness = 100; // aggressiveness 0-100%; every attackFrequencyFrames, roll using this number to see if we attack
attackFrequencyTotalFramesMelee = [20,45];
attackFrequencyTotalFramesRanged = [45,70];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
//meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var longswordSwing = makeEnemyAttackObj(obj_attack_unfairy_longsword_1_1);
var lsSwing2 = makeEnemyAttackObj(obj_attack_unfairy_longsword_1_2);

var longswordStab = makeEnemyAttackObj(obj_attack_unfairy_longsword_2_1);
var longswordStab2 = makeEnemyAttackObj(obj_attack_unfairy_longsword_2_2);
var lsStabNoCharge = makeEnemyAttackObj(obj_attack_unfairy_longsword_3_1);

var c0 = [longswordSwing];
var c1 = [longswordStab,longswordStab2];
var c2 = [longswordStab];
var c3 = [longswordSwing, longswordStab];
var c4 = [lsStabNoCharge];
var c5 = [longswordSwing,  lsSwing2];
var c6 = [longswordSwing, lsSwing2, lsStabNoCharge];
var c7 = [longswordSwing, lsSwing2, longswordSwing];
//meleeAttacks = [meleeChain0, meleeChain1, meleeChain2];
meleeAttacks = [c0,c1,c2,c3,c4,c5,c6,c7];
// ranged attacks info

// currently chosen ranged attack
currentRangedAttack = noone;
rangedRangeArray=[300,500];

var shortbowShot = instance_nearest(x,y,obj_attack_unfairy_shortbow_1_1);
if shortbowShot == noone shortbowShot = instance_create_depth(x,y,1,obj_attack_unfairy_shortbow_1_1);
var rangedChain1 = [shortbowShot,shortbowShot];
var rangedChain2 = [shortbowShot];
rangedAttacks = [rangedChain1,rangedChain2];


hp = 50;
maxHp = 50;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 40;

// dodge stuff
agility = 20; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,20);

soundsWhenHitVocals = [snd_enemy_unfairy_hit1, snd_enemy_unfairy_hit2];
soundsWhenDie = [snd_enemy_unfairy_die];

xpReward = 50;



