event_inherited();
name = "Bug";
spriteName = "bug";
spriteString = "enemy_bug";

functionalSpeed = 3;
normalSpeed = 3;
turnSpeed = 10;

hasHands = false; // humanoid / uses hand attacks
isFairy = false;

// general attacks info
meleeAggroRange = 500;
//rangedAggroRange = 600;
//rangedAggroRange = noone;
farthestAllowedFromPost = 5000;
aggressiveness = 100; // aggressiveness 0-100%, decides how often to keep going with attack chain
attackFrequencyTotalFramesMelee = [25,45];
attackFrequencyTotalFramesRanged = [60,90];
strafeTotalFrames = [30,60];
waryDistanceRange=[100,120];
waryTotalFrames=[120,200];
skittishness = 100;
cautiousness = 100;

// melee attacks info
// meleeAttacksCount is number of separate attack chains, not individual attacks
meleeAttacksCount = 1;
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[5];

// ATTACKS
global.owner = id;
var bugBite = instance_create_depth(x,y,1,obj_attack_bug_head_1_1);

var meleeChain0 = [bugBite];
meleeAttacks = [meleeChain0];

//meleeAttacks = [meleeChain1];

// ranged attacks info
//rangedAttacksCount = 0; 
// currently chosen ranged attack
/*currentRangedAttack = noone;
rangedRangeArray=[300,500];

var shortbowShot = instance_create_depth(x,y,1,obj_attack_unfairy_shortbow_1_1);
var rangedChain1 = [shortbowShot,shortbowShot];
var rangedChain2 = [shortbowShot];
rangedAttacks = [rangedChain1,rangedChain2];
*/
hp = 500;
maxHp = 500;

stamina = 60;
maxStamina = 60;
staminaRegen = 10;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

// stagger stuff
poise = 20;

// dodge stuff
agility = 0; // 0 - 100% chance to try a dodge
//totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

lightRadiusScale = .25;



