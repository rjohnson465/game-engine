/// maybeShield()

if !willDodge {
	
	// go through all equipped limb items and see if you find a shield -- if not, exit
	var ck = ds_map_find_first(equippedLimbItems);
	var hasShieldEquipped = false;
	for (var i = 0; i < ds_map_size(equippedLimbItems); i++) {
		var item = ds_map_find_value(equippedLimbItems, ck);
		if item != undefined && item != noone && item.subType == HandItemTypes.Shield {
			hasShieldEquipped = true;
			break;
		}
		ck = ds_map_find_next(equippedLimbItems, ck);
	}
	
	
	if hasShieldEquipped {
		// if within meleeAggroRange, check every shieldingFrames if should shield
		if !isShielding && stamina > (maxStamina/5) {
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
		}
		// only shield for a finite amount of time, jesus
		else if isShielding {
			if shieldingFrame >= totalShieldingFrames {
				isShielding = false;
				shieldingFrame = 0;
				hasCalculatedWillShield = false;
			}
		}
		else {
			if shieldingFrame >= totalShieldingFrames {
				shieldingFrame = 0;
				hasCalculatedWillShield = false;
			}
		}
		shieldingFrame++;
	}
	
}