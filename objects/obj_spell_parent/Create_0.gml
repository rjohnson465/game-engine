event_inherited();


name = ""; 
castFrames = 30; // how long spell can be charged
numberOfProjectiles = 1;
projectileSpeed = 0;
staminaCost = 0;
numberOfTargets = 1;

maxChargeCost = 10;

staggersAgainstBlocks = false;
staggerDuration = 5;

minDamage = 0;
maxDamage = 0;
// damages of each type
// keys are the damage type
// values are arrays with 2 elements damage range of that type
// can have different damage ranges
damages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(damages,global.ALL_DAMAGE_TYPES[i],[0,0]);
}
