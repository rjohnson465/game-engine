event_inherited();

type = CombatantTypes.Enemy;
name = "parent enemy";
spriteName = "dummy";
spriteType = "enemy";
spriteString = "enemy_dummy";

functionalSpeed = 3;
normalSpeed = 5;

isBoss = false;
isBossKilledBefore = false;
#macro BOSS_HP_X1 300
#macro BOSS_HP_Y1 680
#macro BOSS_HP_X2 1000
#macro BOSS_HP_Y2 695

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
// .5 sec to 1 sec delay between dodges by default
dodgeFrequencyFrames = [15,30];
dodgeFrequencyFrame = 0; // counts down -- when 0, a dodge may happen

// shielding stuff
isShielding = false;
cautiousness = 0;
shieldingFrame = 0; // 0 - 100% chance to shield every totalShieldingFrames # of frames
totalShieldingFrames = 140 - cautiousness; // how regularly can we check to shield?

lockOnTargetType = obj_goodguy_parent;


droppedItems = ds_list_create();
droppedItemsMandatory = ds_list_create();
droppedItemsReplacement = noone;

xpReward = 100;

currentX = postX; currentY = postY; currentZ = postZ;

// new system of storing enemies data -- use properties map, like with persistent room elements
persistentProperties = ds_map_create();
ds_map_replace(persistentProperties, "ObjectIndexName", object_get_name(object_index));
ds_map_replace(persistentProperties, "PostX", postX);
ds_map_replace(persistentProperties, "PostY", postY);
ds_map_replace(persistentProperties, "PostZ", postZ);
ds_map_replace(persistentProperties, "TempPostY", tempPostY);
ds_map_replace(persistentProperties, "TempPostX", tempPostX);
ds_map_replace(persistentProperties, "CurrentX", currentX);
ds_map_replace(persistentProperties, "CurrentY", currentY);
ds_map_replace(persistentProperties, "CurrentZ", currentZ);
//ds_map_replace(persistentProperties, "Hp", hp);
//ds_map_replace(persistentProperties, "MaxHp", maxHp);
ds_map_replace(persistentProperties, "IsAlive", isAlive);
ds_map_replace(persistentProperties, "FacingDirection", facingDirection);
ds_map_replace(persistentProperties, "FacingDirectionStart", facingDirection);

texFrame = 0;
descriptionChoices = [];

doesEnemyRespawn = true;