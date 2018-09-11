/// maybeBecomeWary(*skittishnessFactor)
/// @param *skittishnessFactor

var factor = 1;
if argument_count == 1 {
	factor = argument[0];
}

if type != CombatantTypes.Player {
	randomize();
	var rand = random_range(0,100);
	if rand < skittishness/factor {
		if canJump jumpFrame = 0; 
		waryFrame = round(random_range(waryTotalFrames[0],waryTotalFrames[1]));
		waryDistance = round(random_range(waryDistanceRange[0],waryDistanceRange[1]));
		hasReachedWaryDistance = false;
		if ds_map_find_value(equippedLimbItems,"r") {
			var rightHandItem = ds_map_find_value(equippedLimbItems,"r");
			if rightHandItem.subType == HandItemTypes.Shield {
				isShielding = true;
				global.owner = id;
				instance_create_depth(x,y,1,obj_shield_block);
			}
		}
					
		shieldingFrame = 0;
		state = CombatantStates.Wary;
		return true;
	}
}
return false;