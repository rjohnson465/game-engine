if !willDodge {
	if ds_map_find_value(equippedLimbItems,"r") {
		if ds_map_find_value(equippedLimbItems,"r").subType == HandItemTypes.Shield {
			// if within meleeAggroRange, check every shieldingFrames if should shield
			if !isShielding {
				if shieldingFrame < totalShieldingFrames && !hasCalculatedWillShield {
					randomize();
					totalShieldingFrames = random_range(shieldingFrequencyFrames[0],shieldingFrequencyFrames[1]);
					var rand = random_range(0,1);
					willShield = rand < (cautiousness/100);
					hasCalculatedWillShield = true;
				}
				else if shieldingFrame >= totalShieldingFrames && willShield {
					isShielding = true;
					global.owner = id;
					instance_create_depth(x,y,1,obj_shield_block);
					shieldingFrame = 0;
				}
			} else {
				if shieldingFrame >= totalShieldingFrames {
					shieldingFrame = 0;
					hasCalculatedWillShield = false;
				}
			}
			shieldingFrame++;
		}
	}
}