// personalGrid is all walls / combatants except for this combatant
// each combatant has their own grid, telling them where they can't go
var cell_width = 32;
var cell_height = 32;

var hcells = room_width div cell_width;
var vcells = room_height div cell_height;
personalGrid = mp_grid_create(0,0,hcells,vcells,cell_width, cell_height);
mp_grid_add_instances(personalGrid, obj_wall_parent, false);

isFairy = true;
isPhasing = false;
randomize()
floatingFrame = random_range(0,59); //0-60 "float" for fairies (grow/shrink)

isAlive = true;

lightRadius = 256;
lightRadiusAlpha = .5;
lightRadiusScale = 1;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

idleFrame = 0;

dodgeStartX = noone;
dodgeStartY = noone;
// "jumping" -- just has sprite drawn larger until halfway through jumpTotalFrames
jumpFrame = 8;
jumpTotalFrames = 8;

functionalSpeed = 5;
normalSpeed = 5;
facingDirection = 0;
turnSpeed = 3; // how many degrees a combatant may turn per step to face their target
// player | enemy | ally
spriteType = ""; 
// i.e. "skeleton" | "dummy"
spriteName = "";
spriteString = spriteType + "_" + spriteName;

// "post" for enemies is where they spawn. "post" for allies is near the player
postX = x;
postY = y;
farthestAllowedFromPost = 300;
//testing...
path = path_add();

enum CombatantStates {
	// all combatants -- enemies, player, allies -- can have these states
	Idle,
	Attacking,
	Dodging,
	Staggering,
	Moving, // for player this is based on input. for NPC combatants, this is Pursuing | ReturningToPost
	
	// Only for Ally / Enemy AI
	AggroMelee,
	AggroRanged,
	Wary // prioritize getting away from target / reassessing
}

enum CombatantTypes {
	Player,
	Enemy,
	Ally
}

// idle | moving | attacking | dodging | staggering
state = CombatantStates.Idle;

// general hands stuff
hasHands = true;
currentAttackingHand = noone; // "l" or "r"

// preparing/attacking/recovering limb: kvp are hand|attackNumberInChain
// l and r default for left and right hand
// other special values may be needed for weird monstery enemies
preparingLimbs = ds_map_create();
attackingLimbs = ds_map_create();
recoveringLimbs = ds_map_create();

prepFrames = ds_map_create();
prepFrameTotals = ds_map_create();
ds_map_add(prepFrames,"l",-1);
ds_map_add(prepFrames,"r",-1);
ds_map_add(prepFrameTotals,"r",-1);
ds_map_add(prepFrameTotals,"r",-1);
attackFrames = ds_map_create();
recoverFrames = ds_map_create();
recoverFrameTotals = ds_map_create();
ds_map_add(recoverFrames,"l",-1);
ds_map_add(recoverFrames,"r",-1);
ds_map_add(recoverFrameTotals,"l",-1);
ds_map_add(recoverFrameTotals,"r",-1);
prevAttackLimb = noone;

attackNumberInChain = noone;

// weapons and shields
// map: key values are handSide/type/index 
// i.e. a longsword on right hand for melee set 1 is rm1: <longsword object>
handItems = ds_map_create();

// TODO should replace with map
// kvp = limbKey,item
equippedLimbItems = ds_map_create();
ds_map_replace(equippedLimbItems,"l",noone);
ds_map_replace(equippedLimbItems,"r",noone);

//leftHandItem = noone;
//rightHandItem = noone;

// attack animation stuff
prepAnimationFrame = -1;
prepAnimationTotalFrames = 0;
recoverAnimationFrame = -1;
recoverAnimationTotalFrames = 0;

// this is used to tell enemy / ally they were just hit (useful if in idle and out of normal aggro range)
wasJustHit = false; 

// aggresiveness is how often enemies or allies go to next attack in chain / start an attack chain (0-100%)
aggressiveness = 0;
// attackFrequencyFrame is a range of frame values
// If an enemy or ally has a chosen attack and they are in range of their lockOnTarget,
// every attackFrequencyTotalFrames they check to see if they enter the Attack state
attackFrequencyTotalFrames = [0,0];
attackFrequencyFrame = -1;
// will strafe for x frames before checking if should strafe again
strafeTotalFrames = [0,0];
strafeFrame = -1;
isStrafing = false;
strafeAngle = 0;
strafeDirection = "l"; // l or r

// dodge stuff
dodgeDirection = noone;
dodgeFrame = 0;
totalDodgeFrames = noone;
hasCalculatedWillDodge = false;
willDodge = false;
agility = 100; // 0 - 100% chance to dodge
totalDodgeFrames = sprite_get_number(asset_get_index("spr_"+spriteString+"_dodge"));

// wary / retreat / reassess stuff
skittishness = 0; // chance to fuck off after a dodge or stagger
waryTotalFrames = [0,0]; // be wary for x frames before returning to normal behavior
waryFrame = 0; // count down, not up
waryDistanceRange = [0,0] // how far away from target to fell sort of safe
waryDistance = 0;
hasReachedWaryDistance = false;

// flinch stuff
isFlinching = false;
flinchFrame = 0;
totalFlinchFrames = 0;
flinchDirection = 0;
flinchSpeed = 0;

// shielding stuff
cautiousness = 100; // 0-100% chance to shield (when able, i.e. not attacking, dodging, staggering)
shieldingFrame = 0;
shieldingFrequencyFrames = [30,60]; // range of values for how often to check if should shield
totalShieldingFrames = 0; //stores a value between shieldingFrequencyFrames[0] - [1]
isShielding = false;
hasCalculatedWillShield = false;
willShield = false;

// hp / stamina
hp = 75;
maxHp = 100;
hpRegen = .5; // per second
stamina = 50;
maxStamina = 50;
staminaRegen = 5; // per second

// attributes
strength = 10;
dexterity = 10;
intelligence = 10;
constitution = 10;
adaptability = 10;

perception = 200; // pixel radius enemies / allies will notice if other enemies / allies are engaged in combat

// list of enemy attack instances been hit with -- only get hit once / attack
beenHitWith = ds_list_create();

poise = 1;
staggerDuration = 0;
staggerFrame = 0;
staggerDirection = 0;
staggerSpeed = noone; // optional -- used to indicate slow staggers, mainly

stupidity = 30;
stupidityFrame = 0;

lockOnTarget = noone;
// obj_enemy_parent for allies / player, obj_goodguy_parent for enemies
lockOnTargetType = noone;

// if onAlert, will track these foes down if in range, even if there's a wall between them
onAlert = false;

// spells
knownSpells = ds_map_create();
currentSpell = noone;
currentUsingSpell = noone;

// defenses -- all are initially 0
defenses = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(defenses,global.ALL_DAMAGE_TYPES[i],0);
}

// condition percentages
// burning for fire
// slowed / frozen for ice
// posioned for poison
// electrified for lightning
// bleed for physical? perhaps not
conditionPercentages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(conditionPercentages,global.ALL_DAMAGE_TYPES[i],0);
}

// only 0 or 1 for most conditions, but Ice slows during level 1 and freeze during level 2
conditionLevels = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(conditionLevels,global.ALL_DAMAGE_TYPES[i],0);
}

isSlowed = false;
isFrozen = false;
isPoisoned = false; 
isBurning = false;
isShocked = false;

// by default, burn occurs every second, poison every 2 seconds
// burn does the same small amount of damage each second, while poison damage builds every time it occurs
// this can be effected by poison and fire defenses, and is recalculated every step when a condition is active
burnFrames = 30;
burnFrame = 0;
burnDamage = 0;
poisonFrames = 60;
poisonFrame = 0;
poisonDamage = 0;

// light radius
global.owner = id;
global.makeLightOnCreate = false;
instance_create_depth(x,y,1,obj_light_radius);

__x = 0;
__y = 0;
enemyData = noone;

isDying = false;
dyingFrame = 0;
dyingTotalFrames = 45;
dyingParticleColor1 = c_red;
dyingParticleColor2 = c_maroon;

alpha = 1;

xpReward = 0;