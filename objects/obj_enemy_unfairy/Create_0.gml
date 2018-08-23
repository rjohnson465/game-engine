event_inherited();
name = "Unfairy";
description = "Magic Resistant";
spriteName = "unfairy";
spriteString = "enemy_unfairy";
isFairy = true;

functionalSpeed = 5;
normalSpeed = 5;
turnSpeed = 7;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
unarmed.persistent = false;
var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
woodshield.persistent = false;
var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
longsword.persistent = false;
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
shortbow.persistent = false;
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
farthestAllowedFromPost = 5000;
aggressiveness = 100; // aggressiveness 0-100%, decides how often to keep going with attack chain
attackFrequencyTotalFramesMelee = [10,25];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[60,90];
skittishness = 100;
cautiousness = 50;

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[15, 65, 65];

// ATTACKS
global.owner = id;

var longswordSwing = instance_nearest(x,y,obj_attack_unfairy_longsword_1_1);
if longswordSwing == noone longswordSwing = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_1_1);
//longswordSwing.limbKey = "l";

var longswordStab = instance_nearest(x,y,obj_attack_unfairy_longsword_2_1);
if longswordStab == noone longswordStab = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_2_1);
//longswordStab.limbKey = "l";
var longswordStab2 = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_2_1);
longswordStab2.limbKey = "l";
longswordStab2.coolDownFrames = [90,100];
longswordStab2.turnSpeed = 45;
//longswordStab.isBlockable = false;

var meleeChain0 = [longswordSwing];
var meleeChain1 = [longswordStab,longswordStab2];
var meleeChain2 = [longswordStab];
meleeAttacks = [meleeChain0, meleeChain1, meleeChain2];

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
poise = 20;

// dodge stuff
agility = 20; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(defenses,MAGIC,20);



