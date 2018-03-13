enum AttackTypes {
	Standard,
	Charge
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
nextChoices = [];
projectileSpeed = 0;
numberOfTargets = 1;
staggersAgainstBlocks = true;
type = AttackTypes.Standard;

// must be within this number of pixels of target to begin attack
minRange = 0;