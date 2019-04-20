isObstacleLayerless = false;
// personalGrid is all walls / combatants except for this combatant
// each combatant has their own grid, telling them where they can't go
cell_width = 32;//bbox_right-bbox_left;
cell_height = 32; //bbox_bottom-bbox_top;

var hcells = room_width div cell_width;
var vcells = room_height div cell_height;
personalGrid = noone; //mp_grid_create(0,0,hcells,vcells,cell_width, cell_height);
populatePersonalGrid();
gridPath = path_add();
// these are the x and y locations (in grid coords) of a space that has been
// temporarily declared free (to allow for adequate pathfinding)
gridTempFreeX = noone;
gridTempFreeY = noone;

postX = x; postY = y;
isMoving = false;
movingDirection = 0;

key = fs_generate_key();

//mp_grid_add_instances(personalGrid, obj_wall_parent, false);

isFairy = false;
isFloating = false; // being a Fairy means you float; floating doesn't mean you're a fairy
isPhasing = false;
randomize()
floatingFrame = random_range(0,59); //0-60 "float" for fairies (grow/shrink)
prevX = x;
prevY = y;
endX = x;
endY = y;
walkingSound = noone;
walkingSoundIndex = noone;
walkingEmitter = audio_emitter_create();
audio_emitter_gain(walkingEmitter, 0);
audio_emitter_falloff(walkingEmitter,50,AUDIO_MAX_FALLOFF_DIST,1);
walkingInWaterEmitter = audio_emitter_create();
audio_emitter_gain(walkingInWaterEmitter,0);
audio_emitter_falloff(walkingInWaterEmitter,50,AUDIO_MAX_FALLOFF_DIST,1);
walkingInWaterSoundId = noone;
// decide which water walk sound to play on room start (if floating a different sound is used than if walking)

isAlive = true;

_light_sprite = spr_light_point;
lightRadiusAlpha = .5;
lightRadiusScale = .5;
normalLightRadiusScale = lightRadiusScale;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

idleFrame = 0;

dodgeStartX = noone;
dodgeStartY = noone;

// "jumping" -- just has sprite drawn larger until halfway through jumpTotalFrames
jumpFrame = 12;
jumpTotalFrames = 12;
canJump = true;

// "falling" -- draw sprite from 1-.5, set layer to next lower layer, then from .5 to 1
fallFrame = 32;
fallTotalFrames = 32;
fallScaleFactor = 1;
floorsFallen = 0;

functionalSpeed = 5;
normalSpeed = 5;
isSprinting = false;
sprintParticle = noone;
sprintParticleSystem = noone;
sprintParticleEmitter = noone;
facingDirection = (image_angle+360)%360;
previousFacingDirection = facingDirection;
turnSpeed = 45; // how many degrees a combatant may turn per step to face their target
normalTurnSpeed = turnSpeed;
turningSpeedModifier = 1; // less than 1 when turning a lot
// player | enemy | ally
spriteType = ""; 
// i.e. "skeleton" | "dummy"
spriteName = "";
spriteString = spriteType + "_" + spriteName;

// "post" for enemies is where they spawn. "post" for allies is near the player
postX = x;
postY = y;
postZ = layer;
postDir = facingDirection;
// tempPost is used when not on player layer -- wander around it, but not too far from it
tempPostX = noone;
tempPostY = noone;
wanderDir = 0;

farthestAllowedFromPost = 1000;
path = path_add();

enum CombatantStates {
	// all combatants -- enemies, player, allies -- can have these states
	Idle,
	Attacking,
	Dodging,
	Staggering,
	Moving, // for player this is based on input. for NPC combatants, this is Pursuing | ReturningToPost
	Healing,
	// Only for Ally / Enemy AI
	AggroMelee,
	AggroRanged,
	Wary // prioritize getting away from target / reassessing
}

enum CombatantMoveSubstates {
	Chasing,
	Investigating,
	ReturningToPost
}

enum CombatantTypes {
	Player,
	Enemy,
	Ally
}

// idle | moving | attacking | dodging | staggering
state = CombatantStates.Idle;
substate = noone;

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
attackData = noone // enemies only

// this is used to tell enemy / ally they were just hit (useful if in idle and out of normal aggro range)
wasJustHit = false; 

// aggresiveness is how often enemies or allies go to next attack in chain / start an attack chain (0-100%)
aggressiveness = 0;
// attackFrequencyFrame is a range of frame values
// If an enemy or ally has a chosen attack and they are in range of their lockOnTarget,
// every attackFrequencyTotalFrames they check to see if they enter the Attack state
attackFrequencyTotalFramesMelee = [0,0];
attackFrequencyTotalFramesRanged = [0,0];
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
// default check to go wary every 5-10 seconds in Move state
waryCheckTotalFrames = [150,300]; 
waryCheckFrame = 200;
waryTotalFrames = [0,0]; // be wary for x frames before returning to normal behavior
waryFrame = 0; // count down, not up
waryDistanceRange = [0,0] // how far away from target to fell sort of safe
waryDistance = 0;
hasReachedWaryDistance = false;
jumpSpeedFactor = 2; // most enemies jump backwards at 2*functionalSpeed

// flinch stuff
canFlinch = true;
isFlinching = false;
flinchFrame = 0;
totalFlinchFrames = 0;
flinchDirection = 0;
flinchSpeed = 0;

// shielding stuff
cautiousness = 100; // 0-100% chance to shield (when able, i.e. not attacking, dodging, staggering)
shieldingFrame = 0;
shieldingFrequencyFrames = [90,120]; // range of values for how often to check if should shield
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
staminaRegen = 10; // per second
hpSteal = 0;
staminaSteal = 0;

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
guessPathPts = ds_list_create();
tempTargetX = noone; tempTargetY = noone;
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
conditionPercentages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	ds_map_add(conditionPercentages,global.ALL_ELEMENTS[i],0);
}

// only 0 or 1 for most conditions, but Ice slows during level 1 and freeze during level 2
conditionLevels = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	ds_map_add(conditionLevels,global.ALL_ELEMENTS[i],0);
}
conditionsEmittersMap = ds_map_create();
conditionSoundsMap = ds_map_create(); // stores unique ids for each condition sound
for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	var el = global.ALL_ELEMENTS[i];
	var emitter = audio_emitter_create();
	//var snd = asset_get_index("snd_magic_"+el+"_condition");
	audio_emitter_gain(emitter,0);
	audio_emitter_falloff(emitter,50,AUDIO_MAX_FALLOFF_DIST,1);
	audio_emitter_position(emitter,x,y,depth);
	// TODO -- DO NOT ALWAYS PLAY SOUNDS ON THESE EMITTER JESUS FUCK
	ds_map_replace(conditionSoundsMap, el, noone);
	// audio_play_sound_on(emitter,snd,1,1);
	ds_map_replace(conditionsEmittersMap, el, emitter);
}

isSlowed = false;
slowedSpeedModifier = 1; // less than 1 when slowed
isFrozen = false;
isPoisoned = false; 
isBurning = false;
isShocked = false;
isHexed = false;
isInvulnerable = false;
hexedDamageModifier = 1; // less than 1 when hexed

// by default, burn occurs every second, poison every 2 seconds
// burn does the same small amount of damage each second, while poison damage builds every time it occurs
// this can be effected by poison and fire defenses, and is recalculated every step when a condition is active
burnFrames = 30;
burnFrame = 0;
burnDamage = 0;
poisonFrames = 60;
poisonFrame = 0;
poisonDamage = 0;

// light radius -- only 1/combatant

var lr = noone;
with obj_light_radius {
	if owner == other.id {
		lr = id;
	}
}
if lr == noone {
	global.owner = id;
	global.makeLightOnCreate = false;
	
	if object_index == obj_player {
		var a = 3;
	}
	
	instance_create_depth(x,y,1,obj_light_radius);
}

__x = 0;
__y = 0;

isDying = false;
deathFrameFlag = false;
dyingFrame = 0;
dyingTotalFrames = 45;
dyingParticleColor1 = c_red;
dyingParticleColor2 = c_maroon;

alpha = 1;
scale = 1;

xpReward = 0;

// for changing layer via stairs
layerToChangeTo = noone;
stairsIndex = noone;
climbingDir = noone;

recalculatePathFrame = 15;
recalculatePathFrameTotal = 15;
hasSetGuessPath = false;

chargePointX = noone;
chargePointY = noone;

moveSprite = -1;
moveSpriteImageSpeed = 30;

damagesAttacksFactor = 1; // 1x normal damage to weapons that strike this combatant

isBeingHit = false;

lastAttackHitWith = noone; // either a weapon or attack_data obj

sightAngleDelta = 100; // combatant can see +/- this much in his field of view
hearingDistance = 300; // how far away some hit particles must be for enemy to investigate
investigatingFramesTotal = 200;
investigatingFrame = 0;
investigatingDirectionPrev = 0;
investigatingDirection = 0;
investigationPtX = noone; investigationPtY = noone;
isInvestigatingMoving = false;
minAggroRange = 15; // when the player get this close, no matter what, aggro

currentSpellPrepSound = noone;
soundsWhenDodge = [snd_dodge1];
soundsWhenHit = [snd_hit1]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)
soundsWhenHitVocals = [];
soundsWhenDie = [];

randomize();
var s = sprite_get_name(sprite_index);
image_index = round(random_range(0,sprite_get_number(sprite_index)));

RECALC_PATH_FRAMES = 7;
randomize();
alarm[9] = round(random_range(1,RECALC_PATH_FRAMES)); // update "path" every RECALC_PATH_FRAMES frames

alarm[0] = 15; // reassess melee attack if in range

usesDefaultIdleState = true;
usesDefaultMoveState = true;
staysOutOfEnemies = true;

attackPrepSoundEmitter = audio_emitter_create();
audio_emitter_gain(attackPrepSoundEmitter, 0);

// attack prep particles stuff
appSystem = part_system_create();
appEmitter = part_emitter_create(appSystem);

// reassess maybeAggro every 15 frames, if in idle state
alarm[1] = 15;

// predicate for whether or not is fine for this combatant to overlay with allies
canIntersectWithAllies = false;

chanceToDropHealthOrb = .33; // 0 - 1 odds to drop a health orb on death