enum AttackTypes {
	Standard,
	Charge,
	AOE,
	Zone // breath attacks, poison clouds, whatever
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
isBlockable = true;
projectileSpeed = 0;
numberOfTargets = 1;
staggersAgainstBlocks = true;
type = AttackTypes.Standard;
prepSound = noone;
attackSound = noone;
hitSound = noone;

// must be within this number of pixels of target to begin attack
minRange = 0;

// if this is the last attack in a chain, the combatant's attackFrequencyFrames is set to this array
coolDownFrames = [25,40]; 

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