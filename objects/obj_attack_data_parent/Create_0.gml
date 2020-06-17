enum AttackTypes {
	Standard,
	Charge,
	AOE,
	Zone, // breath attacks, poison clouds, whatever
	MultiRand, // multiple random projectiles at random locations
	Beam, // Laserrrr
	UnderPlayer // A "projectile" that attacks from right under the player
}

owner = global.owner;
spriteName = "";
// e-either and o-other only apply to l and r hand limbs.

/*
Left - l
Right - r
Same as previous attack limb - s
Either (left or right) - e
Other (left or right) - o 
<limbKey> - specific limb key
noone - this attack comes from the core body
*/
limbKey = noone; // l | r | s | e | o | <limbKey> | noone

damages = ds_map_create();
isRanged = false;

isSpell = false;
numberOfProjectiles = 1;
spellName = "";

isBlockable = true;
projectileSpeed = 0;
numberOfTargets = 1;
staggersAgainstBlocks = true;
type = AttackTypes.Standard;
prepSound = noone;
attackSound = noone;
attackSoundLoop = noone;
attackSoundsDuring = noone;
recoverSound = noone;
hitSound = noone;
mustVocalizeAttack = false;
mustVocalizePrep = false;
attackSoundsVocals = [];
prepSoundsVocals = [];
prepSoundsUninterruptible = [];

attackStartX = noone;
attackStartY = noone;
attackStartOffsetX = noone;
attackStartOffsetY = noone;
attackStartInstance = noone;

attackScaleX = noone;
attackScaleY = noone;

stopsAtObstacles = true;

chargePrepSpeed = noone; // how fast to move back in prep for charge, if this is an attack of type Charge
chargeSpeed = noone; // how fast to charge, if this is an attack of type Charge

// must be within this number of pixels of target to begin attack
minRange = 0;

// if this is the last attack in a chain, the combatant's attackFrequencyFrames is set to this array
coolDownFrames = noone;

// how fast the owner may turn when prepping this attack
turnSpeed = owner.turnSpeed;

// aoe stuff
part1 = noone;
part2 = noone;
numberOfProjectiles = noone;
aoeOnlyHitsOnce = true;
part1Num = noone;
part2Num = noone;

damageType = "Block"; // Block (sparks) or Dust (for when attack hits walls)

zoneCanHitShield = false;

conditionsChances = ds_map_create();
doesNotStagger = false; // attacks normally have a chance to stagger opponents. Some (like zones) may not

// particles to make during prep
prepPart1 = noone;
prepPart1Num = 4;
prepPart1BelowOwner = false;
// this is a four digit array, with top, left, right, and bottom offsets (from the attacker's origin)
prepPartBoundingBox = noone;
prepPartStartFrame = noone;

// if there is a sound that should play mid attack, specify the sound and the frame here
attackSoundMid = noone;
attackSoundMidFrame = noone;
// any particles that should be made during the attack (like smoke from slamming hammer against ground)
attackPart = noone;
attackPartBoundingBox = noone;
attackPartStartFrame = noone;
attackPartEndFrame = noone;
attackPartNum = 4;
// trail particles 
trailPart = noone;
trailStarts = noone;
trailEnds = noone;
trailPartNum = 4;
prepTrailPart = noone;
prepTrailStarts = noone;
prepTrailEnds = noone;
prepTrailPartNum = 4;

// function to fire as attack starts
attackFunc = noone;

usesWeapon = false;

// For AOE attacks -- how many degrees all attacks span
spreadTotal = 360; 
aoeStartOffset = 0; // how many degrees different from facingDirection AOE attack spread starts

// optional array for AOE attacks
// tells what the direction for each numbered projectile should be, relative to owner.facingDirection
// if this is supplied, aoeStartOffset is ignored
aoeProjectilesDirectionOffsetArray = noone;

// if a weapon is required for this attack, the attacker must switch to this weapon before attack begins
weaponRequired = noone;

attackObjectIndex = noone;

isVisible = true;
refreshCombatantsHit = 15; // hit 2 times / second
beamMaxReach = 1000;
beamHasLight = true;
beamLightColor = c_white;
beamLightAlpha = .5;
beamWidthWaverArray = [1, 1];
beamHitMakesLight = true;
beamHitLightColor = c_white;
beamHitLightAlpha = .85;
beamHitLightScale = .15;
beamHitLightScaleWaverArray = [.1, .25];
// beam hit particles are in form [[parttype, num], [parttype, num]....]
beamHitParticlesArr = [];
beamHitSoundLoop = noone;

bouncesOffWalls = false;

life = noone; // how long ranged attacks last

zonePartNum = noone; // specify to say how many zone particles to spawn per frame, for zone attacks

turnsDuringAttack = false;
turnSpeedAttack = 0;

movesDuringAttack = true;
movesDuringPrep = true;

// Linger zone -- after attack ends, maybe leave a linger zone that damages player for a while
underPlayerAttackSound = noone;
underPlayerPrepDuration = 30; // default 1 second
hasLingerZone = false;
lingerZonePartTypes = [];
lingerZoneDamages = noone; // a map of damages the linger zone delivers
lingerZoneDuration = 150; // 5 seconds by default
lingerZoneDamageFrequency = 30; // damage every second, by default
lingerZoneSoundInit = noone;

resetCombatantsHitFrame = noone;
extraHitsDamages = ds_map_create();

hasLightRadius = false;
lightRadiusAlpha = .2;
lightRadiusScale = .23;
lightRadiusScaleX = .23;
lightRadiusScaleY = .23;
lightRadiusOffsetX = noone;
lightRadiusOffsetY = noone;
lightRadiusScalesByFrame = noone;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;

// tracking?
tracksTargets = false;
trackingMinDistance = 1000;
isTracking = true; // stop tracking if hit player dodging ??