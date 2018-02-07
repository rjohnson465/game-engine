owner = global.owner;
spriteName = "";
// e-either and o-other only apply to l and r hand limbs.
handSide = noone; // l | r | s | e | o | <limbKey>

damages = ds_map_create();
isRanged = false;
nextChoices = [];
projectileSpeed = 0;
numberOfTargets = 1;
staggersAgainstBlocks = true;