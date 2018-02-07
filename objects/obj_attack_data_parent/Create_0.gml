owner = global.owner;
spriteName = "";
// e-either and o-other only apply to l and r hand limbs.
limbKey = noone; // l | r | s | e | o | <limbKey> | noone

damages = ds_map_create();
isRanged = false;
nextChoices = [];
projectileSpeed = 0;
numberOfTargets = 1;
staggersAgainstBlocks = true;