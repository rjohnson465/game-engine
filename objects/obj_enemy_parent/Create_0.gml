event_inherited();
type = CombatantTypes.Enemy;
name = "parent enemy";
spriteName = "dummy";
spriteType = "enemy";
spriteString = "enemy_dummy";

functionalSpeed = 3;
normalSpeed = 5;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

state = CombatantStates.Idle;

// stupidity is how many frames enemy will stay in thinking state
stupidity = 15; // default .5 second in thinking state
stupidityFrame = 0;

// general attacks info
meleeAggroRange = 200;
rangedAggroRange = 350;
farthestAllowedFromPost = 1000;
attackNumberInChain = noone; // set in attack state
aggressiveness = 100; // aggressiveness 0-100%, decides how often to keep going with attack chain
attackFrequencyTotalFrames = [5,15];
strafeTotalFrames = [30,60];
hasCalculatedNextAttack = false; // flag to ensure aggresiveness is only factored once between attacks

// melee attacks info
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[];
meleeAttacks = []; // melee attack chains

// ranged attacks info
// currently chosen ranged attack
currentRangedAttack = noone;
rangedRangeArray=[]; // ranged attack chains

hp = 35;
maxHp = 35;
hpRegen = 0;

stamina = 15;
maxStamina = 15;
staminaRegen = 4;

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

facingDirection = 0;

// stagger stuff
poise = 20;
staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;

// dodge stuff
hasCalculatedWillDodge = false;
willDodge = noone;
agility = 0; // 0 - 100% chance to try a dodge
dodgeFrame = 0;
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

// shielding stuff
isShielding = false;
cautiousness = 0;
shieldingFrame = 0; // 0 - 100% chance to shield every totalShieldingFrames # of frames
totalShieldingFrames = 140 - cautiousness; // how regularly can we check to shield?

lockOnTargetType = obj_goodguy_parent;

global.owner = id;
instance_create_depth(x,y,1,obj_enemy_gui);

// items as keys (or function to return item) with probability as values
dropItems = ds_map_create();

xpReward = 100;