enum SpellTypes {
	Martial,
	Healing
}

name = ""; // i.e. magicmissile, fireball ...
type = SpellTypes.Martial;
castFrames = 30; // how long spell can be charged
numberOfProjectiles = 1;
projectileSpeed = 0;
staminaCost = 0;

maxChargeCost = 10;

minDamage = 0;
maxDamage = 0;
// damages of each type
// keys are the damage type
// values are arrays with 2 elements damage range of that type
// physical damage array can have more than 2 elements -- each attack in a combo 
// can have different damage ranges
damages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(damages,global.ALL_DAMAGE_TYPES[i],[0,0]);
}
