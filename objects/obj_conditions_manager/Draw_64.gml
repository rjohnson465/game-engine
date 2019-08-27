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
	
}


