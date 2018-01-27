event_inherited();
name = "Dummy Enemy";
spriteName = "dummy";
spriteString = "enemy_dummy";

functionalSpeed = 5;
normalSpeed = 5;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
ds_map_add(handItems,"rm1",unarmed);
ds_map_add(handItems,"lm1",unarmed);
ds_map_add(handItems, "rr1",shortbow);
ds_map_add(handItems, "lr1", unarmed);

leftHandItem = instance_create_depth(x,y,1,obj_hand_item_unarmed);
rightHandItem = instance_create_depth(x,y,1,obj_hand_item_unarmed);

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 200;
rangedAggroRange = 500;
farthestAllowedFromPost = 1000;
aggressiveness = 80; // aggressiveness 0-100%, decides how often to keep going with attack chain
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
var unarmedHook1 = instance_create_depth(x,y,1,obj_attack_dummy_unarmed_1_1);
unarmedHook1.handSide = "e";
ds_map_replace(unarmedHook1.damages,FIRE,[1,3]);
var unarmedHook2 = instance_create_depth(x,y,1,obj_attack_dummy_unarmed_1_1);
unarmedHook2.handSide = "o";
var unarmedHook3 = instance_create_depth(x,y,1,obj_attack_dummy_unarmed_1_1);
unarmedHook3.handSide = "o";
ds_map_replace(unarmedHook3.damages,FIRE,[1,3]);

var unarmedBackSlap = instance_create_depth(x,y,1,obj_attack_dummy_unarmed_1_2);

var meleeChain1 = [unarmedHook1,unarmedHook2,unarmedHook3];
var meleeChain2 = [unarmedHook1,unarmedBackSlap];
var meleeChain3 = [unarmedHook1,unarmedBackSlap,unarmedHook2];
var meleeChain4 = [unarmedHook1,unarmedBackSlap,unarmedHook2,unarmedHook3];
meleeAttacks = [meleeChain1,meleeChain2,meleeChain3];

// ranged attacks info
rangedAttacksCount = 1; 
// currently chosen ranged attack
currentRangedAttack = noone;
rangedRangeArray=[300,500];

var shortbowShot = instance_create_depth(x,y,1,obj_attack_dummy_shortbow_1_1);
var rangedChain1 = [shortbowShot,shortbowShot];
var rangedChain2 = [shortbowShot];
rangedAttacks = [rangedChain1,rangedChain2];

hp = 100;
maxHp = 100;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 20;

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

ds_map_replace(dropItems,makeItem(1),100);
ds_map_replace(dropItems,makeGold(0,10),100);

