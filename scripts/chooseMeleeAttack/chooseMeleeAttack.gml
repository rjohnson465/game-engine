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
var attacksInRange = ds_list_create();
var furthestRange = 0;
for (var i = 0; i < array_length_1d(meleeRangeArray); i++) {
	var r = meleeRangeArray[i];
	if r <= range {
		// add this attackChain index to attacksInRange
		ds_list_add(attacksInRange,i+1);
	}
	if r >= furthestRange && r <= range {
		furthestRange = r;
	}
}
// now go through attacks in range and find the one(s) at the furthestRange
var furthestRangeAttacks = ds_list_create();
for (var i = 0; i < ds_list_size(attacksInRange); i++) {
	var r = meleeRangeArray[i];
	if r == furthestRange {
		ds_list_add(furthestRangeAttacks,i+1);
	}
}


randomize();
//currentMeleeAttack = round(random_range(1,array_length_1d(meleeAttacks)));
var currentMeleeAttackIndex = round(random_range(0,ds_list_size(furthestRangeAttacks)-1));
currentMeleeAttack = ds_list_find_value(furthestRangeAttacks,currentMeleeAttackIndex);
onAlert = true;
isShielding = false;
				
// TODO -- melee 2H accounting
var rightHandItem = ds_map_find_value(handItems,"rm1");
var leftHandItem = ds_map_find_value(handItems,"lm1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);

// prevent memory leaks
ds_list_destroy(furthestRangeAttacks);
ds_list_destroy(attacksInRange);
state = CombatantStates.Moving;