// pick a melee attack 
lockOnTarget = instance_nearest(x,y,lockOnTargetType);
currentRangedAttack = noone;
attackNumberInChain = noone;
randomize();
currentMeleeAttack = round(random_range(1,array_length_1d(meleeAttacks)));

onAlert = true;
isShielding = false;
				
// TODO -- melee 2H accounting
var rightHandItem = ds_map_find_value(handItems,"rm1");
var leftHandItem = ds_map_find_value(handItems,"lm1");
ds_map_replace(equippedLimbItems,"l",leftHandItem);
ds_map_replace(equippedLimbItems,"r",rightHandItem);
state = CombatantStates.Moving;