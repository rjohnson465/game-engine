// pick a melee attack 
// this might be a dumb way to pick a lockOnTarget...
lockOnTarget = instance_nearest(x,y,lockOnTargetType);
currentRangedAttack = noone;
attackNumberInChain = noone;

// pick the longest-range melee attack we can 
// look at all possible melee attack ranges
// which ones are within our range?
// which one(s) have the longest possible range?
var range = distance_to_object(lockOnTarget);

// find the attack(s) with range closest to our current range
var closestRange = 0; var closestDiff = 1000;
for (var i = 0; i < array_length_1d(meleeRangeArray); i++) {
	var r = meleeRangeArray[i];
	var rangeDiff = abs(range-r);
	if rangeDiff < closestDiff {
		closestRange = r;
		closestDiff = rangeDiff;
	}
}
// now go through attacks and find one(s) with range "closestRange"
var properRangeAttacks = ds_list_create();
for (var i = 0; i < array_length_1d(meleeRangeArray); i++) {
	var r = meleeRangeArray[i];
	if r == closestRange {
		ds_list_add(properRangeAttacks,i+1);
	}
}

randomize();
//currentMeleeAttack = round(random_range(1,array_length_1d(meleeAttacks)));
var currentMeleeAttackIndex = round(random_range(0,ds_list_size(properRangeAttacks)-1));

currentMeleeAttack = ds_list_find_value(properRangeAttacks,currentMeleeAttackIndex);

onAlert = true;
isShielding = false;
				
// TODO -- melee 2H accounting
var rightHandItem = ds_map_find_value(handItems,"rm1");
var leftHandItem = ds_map_find_value(handItems,"lm1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);

// prevent memory leaks
ds_list_destroy(properRangeAttacks);

state = CombatantStates.Moving;