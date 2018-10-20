/// chooseMeleeAttack()
// pick a melee attack 
// this might be a dumb way to pick a lockOnTarget...
lockOnTarget = instance_nearest(x,y,lockOnTargetType);
currentRangedAttack = noone;
attackNumberInChain = noone;

var range = distance_to_object(lockOnTarget);

// build meleeRangeArray based off the "minRange" property of the first attackData object in each chain
var meleeRangeArray = [];
for (var i = 0; i < array_length_1d(meleeAttacks); i++) {
	/*var currentMeleeChain = meleeAttacks[i];
	var firstAttackDataObj = currentMeleeChain[0];
	meleeRangeArray[i] = firstAttackDataObj.minRange;*/
	meleeRangeArray[i] = getRangeForAttackIndex(i,true);
}

var differences = ds_list_create();
for (var i = 0; i < array_length_1d(meleeRangeArray); i++) {
	var diff = abs(meleeRangeArray[i]-range);
	if ds_list_find_index(differences, diff) == -1 {
		ds_list_add(differences, diff);
	}
}

ds_list_sort(differences,1);

var n =ds_list_size(differences);
randomize();
var fac = factorial(n);
var rand = round(random_range(0,fac));

var cumSum = 0; var diffSelected = noone;
for (var i = 0; i < ds_list_size(differences); i++) {
	var lowerBound = cumSum;
	var upperBound = cumSum + (n-i);
	if rand >= lowerBound && rand < upperBound {
		diffSelected = ds_list_find_value(differences, i);
	}
	cumSum += (n-i);
}
if diffSelected == noone {
	diffSelected = ds_list_find_value(differences,0);
}

// find the attack(s) with range closest to our current range
var properRangeAttacks = ds_list_create();
for (var i = 0; i < array_length_1d(meleeRangeArray); i++) {
	var r = meleeRangeArray[i];
	var rangeDiff = abs(range-r);
	if rangeDiff == diffSelected {
		ds_list_add(properRangeAttacks,i);
	}
}
randomize();
var currentMeleeAttackIndex = round(random_range(-.49,ds_list_size(properRangeAttacks)-.51));
if currentMeleeAttackIndex == 3 {
	var a = 3;
}

currentMeleeAttack = ds_list_find_value(properRangeAttacks,currentMeleeAttackIndex);
onAlert = true;
isShielding = false;
				
// TODO -- melee 2H accounting
var rightHandItem = ds_map_find_value(handItems,"rm1");
var leftHandItem = ds_map_find_value(handItems,"lm1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);

// prevent memory leaks
ds_list_destroy(properRangeAttacks); properRangeAttacks = -1;
ds_list_destroy(differences); differences = -1;

if array_length_1d(meleeAttacks) == 0 currentMeleeAttack = noone;

state = CombatantStates.Moving;
substate = CombatantMoveSubstates.Chasing;