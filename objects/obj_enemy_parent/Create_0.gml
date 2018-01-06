event_inherited();
type = CombatantTypes.Enemy;
name = "parent enemy";
spriteName = "dummy";
spriteType = "enemy";
spriteString = "enemy_dummy";

functionalSpeed = 3;

hasHands = true; // humanoid / uses hand attacks
currentAttackingHand = noone; // hide current attack hand default image when attacking with it

// all weapons / shields enemy can use
var unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
var woodshield = instance_create_depth(x,y,1,obj_hand_item_woodshield);
var shortbow = instance_create_depth(x,y,1,obj_hand_item_shortbow);
ds_map_add(handItems,"rm1",unarmed);
ds_map_add(handItems,"lm1",woodshield);
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
rangedAggroRange = 350;
farthestAllowedFromPost = 1000;
attackNumberInChain = noone; // set in attack state
aggressiveness = 50; // aggressiveness 0-100%, decides how often to keep going with attack chain
hasCalculatedNextAttack = false; // flag to ensure aggresiveness is only factored once between attacks
isPreparingAttack = false; 
isAttacking = false;
isRecovering = false;
// attack animation stuff
prepAnimationFrame = -1;
prepAnimationTotalFrames = 0;
recoverAnimationFrame = -1;
recoverAnimationTotalFrames = 0;

// melee attacks info
// meleeAttacksCount is number of separate attack chains, not individual attacks
meleeAttacksCount = 1;
if meleeAttacksCount == 0 {
	meleeAggroRange = noone;
}
// currently chosen melee attack chain
currentMeleeAttack = noone;
// the minimum range for each melee attack chain (index 0 refers to attack chain 1, index 1 refers to attack chain 2...)
meleeRangeArray=[3];
meleeAttacksHands = noone;
// need to say from which hand each attack in each attack chain comes from
if (hasHands) {
	// index 0:attack 1 - array for each hand in attack chain
	// will need to manually set this 2d array for EVERY enemy
	// e: either hand
	// s: same as last hand
	// o: other hand (from last attack)
	// l: left
	// r: right
	meleeAttacksHands[0] = ["r", "s"];
}

// TODO -- handle these with hand item stats (unless no hands for enemy)
// 2d array needs to be set manually for EVERY enemy
// attack 1 move 1 min, attack 1 move 1 max, attack 1 move 2 min, attack 1 move 2 max..
//meleeAttacksDamages[0] = [10,20,25,35]; 
// melee damages is array of maps
//meleeDamages = [];
var meleeDamages0 = ds_map_create();
ds_map_add(meleeDamages0,PHYSICAL,[10,20,25,25]);
meleeDamages[0] = meleeDamages0;

// melee attack chain 1 damages
//ds_map_add(damages,PHYSICAL+"1",[10,20,25,25]);

// 2d array needs to be set manually for EVERY enemy
// attack 1 move 1 min, attack 1 move 1 max, attack 1 move 2 min, attack 1 move 2 max..
meleeAttacksStaggerDuration[0] = [15,30];

// ranged attacks info
rangedAttacksCount = 0; //TODO change back to 1
if rangedAttacksCount == 0 {
	rangedAggroRange = noone;
}
// currently chosen ranged attack
currentRangedAttack = noone;
rangedRangeArray=[300];
//rangedDamages = [];
var rangedDamages0 = ds_map_create();
ds_map_add(rangedDamages0,PHYSICAL,[10,20]);
rangedDamages[0] = rangedDamages0;

strength = 10; // used in calculating stagger against player

hp = 75;
maxHp = 75;
prevHp = 75;

stamina = 15;
maxStamina = 15;
staminaRegen = 4;

// TODO
//hitsToDrain = ds_list_create();

beenHit = false; // hit during an attack animation
showHp = false; // hit at all (flag for showing health bar)

enemySpeed = 3;
facingDirection = 0;

// stagger stuff
poise = 20;
staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;

// dodge stuff
hasCalculatedWillDodge = false;
willDodge = noone;
agility = 50; // 0 - 100% chance to try a dodge
dodgeFrame = 0;
totalDodgeFrames = sprite_get_number(asset_get_index("spr_enemy_"+spriteName+"_dodge"));

// shielding stuff
isShielding = false;
cautiousness = 50;
shieldingFrame = 0; // 0 - 100% chance to shield every totalShieldingFrames # of frames
totalShieldingFrames = 130 - cautiousness; // how regularly can we check to shield?

lockOnTargetType = obj_goodguy_parent;

