event_inherited();

enum HandItemTypes {
	Shield,
	Melee,
	Ranged
}

isStackable = false;

subType = ""; // HandItemType
weaponType = SWORD1H;
// Fast | Medium | Slow -- dependent on WeaponType
weaponSpeed = "";
range = 1000; // in pixels
numberOfTargets = [1];
staggersAgainstBlocks = true;
charges = 0;
chargesMax = 0;

level = 1;
act = 0;

attackSounds = [];
hitSounds = [];
prepSounds = [];
// two handed weapons always held with "right hand" (on right side)
isTwoHanded = false;
staminaCostArray=[];

isRanged = false;

durability = 50;
durabilityMax = 50;

ammo = 5;
ammoMax = 5;

charges = 0;
chargesMax = 0;

// damages of each type
// keys are the damage type
// values are arrays with 2 elements damage range of that type
// physical damage array can have more than 2 elements -- each attack in a combo 
// can have different damage ranges
damages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(damages,global.ALL_DAMAGE_TYPES[i],[0,0]);
}

// poise damage -- often just the same as damages, and not defined
damagesPoise = ds_map_create();

numberOfSockets = 0;

requiredMastery = 0;


weight = 7;
