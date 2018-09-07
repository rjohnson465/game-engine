// pick a ranged attack
// if we're just aggroing for the first time, show a ! above enemy head so player knows theyve been spotted
if lockOnTarget == noone {
	drawCombatText("!",id);
}
lockOnTarget = instance_nearest(x,y,lockOnTargetType);
currentMeleeAttack = noone;
attackNumberInChain = noone;
currentRangedAttack = round(random_range(0,array_length_1d(rangedAttacks)-1));
onAlert = true;
isShielding = false;
				
rightHandItem = ds_map_find_value(handItems,"rr1");
leftHandItem = ds_map_find_value(handItems,"lr1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);
				
state = CombatantStates.Moving;
substate = CombatantMoveSubstates.Chasing;