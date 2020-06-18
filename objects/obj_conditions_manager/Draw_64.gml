var condisCount = 0;
with obj_player {
	// conditions buildup first
	var ck = ds_map_find_first(conditionsBuildupMap);
	for (var i = 0; i < ds_map_size(conditionsBuildupMap); i++) {
		var condiPerc = ds_map_find_value(conditionsBuildupMap, ck);
		if condiPerc != undefined && condiPerc > 0 {
			// draw the buildup condi
			var cData = getConditionData(ck);
			var cCol = cData[0];
			var spr = cData[1];
			var sprScale = cData[2];
			var doDrawBack = cData[3];
			drawCondition(.5, condisCount, condiPerc, spr, sprScale, doDrawBack, cCol);
			condisCount++;
		}
		ck = ds_map_find_next(conditionsBuildupMap, ck);
	}
	
	// active condis next
	var ck = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages); i++) {
		var condiPerc = ds_map_find_value(conditionPercentages, ck);
		if condiPerc != undefined && condiPerc > 0 {
			// draw the active condi
			var cData = getConditionData(ck);
			var cCol = cData[0];
			var spr = cData[1];
			var sprScale = cData[2];
			var doDrawBack = cData[3];
			drawCondition(1, condisCount, condiPerc, spr, sprScale, doDrawBack, cCol);
			condisCount++;
		}
		ck = ds_map_find_next(conditionPercentages, ck);
	}
	
	// also do temp damages (from gempieces)
	var mainWeapon = ds_map_find_value(global.player.equippedLimbItems, "r");
	if instance_exists(mainWeapon) && ds_list_size(mainWeapon.temporaryDamages) > 0 {
		var tempDamages = mainWeapon.temporaryDamages;
		for (var i = 0; i < ds_list_size(tempDamages); i++) {
			var tempDamageEntry = ds_list_find_value(tempDamages, i);
			if tempDamageEntry != undefined && is_array(tempDamageEntry) {
				// draw the temp damage 
				var curFrame = tempDamageEntry[1];
				var totalFrames = tempDamageEntry[3];
				var spr = tempDamageEntry[4];
				
				var cCol = c_ltgray;
				var condiPerc = (curFrame / totalFrames)*100;
				sprScale = .3125;
				
				drawCondition(1, condisCount, condiPerc, spr, sprScale, true, cCol);
				condisCount++;
			}
		}
	}
	
	// also do tempDefenses (from condition cures used when not conditioned)
	for (var i = 0; i < ds_list_size(temporaryDefenses); i++) {
			var tempDefEntry = ds_list_find_value(temporaryDefenses, i);
			if tempDefEntry != undefined && is_array(tempDefEntry) {
				// draw the temp defense 
				var curFrame = tempDefEntry[1];
				var totalFrames = tempDefEntry[3];
				var spr = tempDefEntry[4];
				
				var cCol = c_ltgray;
				var condiPerc = (curFrame / totalFrames)*100;
				sprScale = .3125;
				
				drawCondition(1, condisCount, condiPerc, spr, sprScale, true, cCol);
				condisCount++;
			}
		}
	
}


