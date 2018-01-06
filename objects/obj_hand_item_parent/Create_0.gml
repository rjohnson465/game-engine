event_inherited();

enum HandItemTypes {
	Shield,
	Melee,
	Ranged
}
type = "";
// Fast | Medium | Slow
weaponSpeed = "";

charges = 0;
totalCharges = 0;

// two handed weapons always held with "right hand" (on right side)
isTwoHanded = false;
// 0-1 min/max attack 1, 2-3 min/max attack 2, 3-4 min/max attack3
physicalDamageArray = [-1,-1,-1,-1,-1,-1]
// slash, pierce, crush
physicalDamageTypeArray = ["","",""];
staminaCostArray=[];

// damages of each type
// keys are the damage type
// values are arrays with 2 elements damage range of that type
// physical damage array can have more than 2 elements -- each attack in a combo 
// can have different damage ranges
damages = ds_map_create();
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	ds_map_add(damages,global.ALL_DAMAGE_TYPES[i],[0,0]);
}
