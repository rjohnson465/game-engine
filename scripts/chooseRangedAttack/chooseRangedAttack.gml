// pick a ranged attack
lockOnTarget = instance_nearest(x,y,lockOnTargetType);
currentMeleeAttack = noone;
attackNumberInChain = noone;
currentRangedAttack = round(random_range(0,array_length_1d(rangedAttacks)-1));
if array_length_1d(rangedAttacks) == 0 currentRangedAttack = noone;
onAlert = true;
isShielding = false;
				
rightHandItem = ds_map_find_value(handItems,"rr1");
leftHandItem = ds_map_find_value(handItems,"lr1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);
				
state = CombatantStates.Moving;
substate = CombatantMoveSubstates.Chasing;