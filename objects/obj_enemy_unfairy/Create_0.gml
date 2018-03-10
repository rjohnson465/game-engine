event_inherited();
name = "Unfairy";
spriteName = "unfairy";
spriteString = "enemy_unfairy";

functionalSpeed = 5;
normalSpeed = 5;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
var longsword = instance_create_depth(x,y,1,obj_hand_item_longsword);
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
ds_map_add(handItems,"rm1",longsword);
ds_map_add(handItems,"lm1",unarmed);
ds_map_add(handItems, "lr1",shortbow);
ds_map_add(handItems, "rr1", unarmed);

ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"r",longsword);
var rightHand = makeLimb(id,"r");
var leftHand = makeLimb(id,"l");

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 200;
rangedAggroRange = 600;
//rangedAggroRange = noone;
farthestAllowedFromPost = 10000;
aggressiveness = 100; // aggressiveness 0-100%, decides how often to keep going with attack chain
attackFrequencyTotalFrames = [5,15];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[120,200];
skittishness = 100;

// melee attacks info
// meleeAttacksCount is number of separate attack chains, not individual attacks
meleeAttacksCount = 1;
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[5,5,5,5];

// ATTACKS
global.owner = id;
var longswordSwing = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
longswordSwing.limbKey = "r";
var meleeChain0 = [longswordSwing];
meleeAttacks = [meleeChain0];
/*
var unarmedHook1 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook1.limbKey = "l";
var unarmedHook2 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook2.limbKey = "o";
var unarmedHook3 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook3.limbKey = "o";

var unarmedBackSlap = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_2);

var meleeChain0 = [unarmedHook1];
var meleeChain1 = [unarmedHook1,unarmedHook2,unarmedHook3];
var meleeChain2 = [unarmedHook1,unarmedBackSlap];
var meleeChain3 = [unarmedHook1,unarmedBackSlap,unarmedHook2];
var meleeChain4 = [unarmedHook1,unarmedBackSlap,unarmedHook2,unarmedHook3];
meleeAttacks = [meleeChain1,meleeChain2,meleeChain3];
*/
//meleeAttacks = [meleeChain1];

// ranged attacks info
//rangedAttacksCount = 0; 
// currently chosen ranged attack
currentRangedAttack = noone;
rangedRangeArray=[300,500];

var shortbowShot = instance_create_depth(x,y,1,obj_attack_unfairy_shortbow_1_1);
var rangedChain1 = [shortbowShot,shortbowShot];
var rangedChain2 = [shortbowShot];
rangedAttacks = [rangedChain1,rangedChain2];
//rangedAttacks = noone;

hp = 500;
maxHp = 500;

stamina = 60;
maxStamina = 60;
staminaRegen = 7;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 20;

// dodge stuff
agility = 100; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));



