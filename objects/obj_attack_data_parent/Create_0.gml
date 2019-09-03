enum AttackTypes {
	Standard,
	Charge,
	AOE,
	Zone, // breath attacks, poison clouds, whatever
	MultiRand, // multiple random projectiles at random locations
	Beam, // Laserrrr
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
recoverSound = noone;
hitSound = noone;
mustVocalizeAttack = false;
mustVocalizePrep = false;
attackSoundsVocals = [];
prepSoundsVocals = [];

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
part1Num = noone;
part2Num = noone;

damageType = "Block"; // Block (sparks) or Dust (for when attack hits walls)

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