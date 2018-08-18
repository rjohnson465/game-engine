event_inherited();

ds_list_destroy(droppedItems); droppedItems = -1;
ds_list_destroy(beenHitWith); beenHitWith = -1;

ds_map_destroy(preparingLimbs); preparingLimbs = -1;
ds_map_destroy(attackingLimbs); attackingLimbs = -1;
ds_map_destroy(recoveringLimbs); recoveringLimbs = -1;
ds_map_destroy(prepFrames); prepFrames = -1;
ds_map_destroy(attackFrames); attackFrames = -1;
ds_map_destroy(recoverFrames); recoverFrames = -1;
ds_map_destroy(prepFrameTotals); prepFrameTotals = -1;
//ds_map_destroy(attackFrameTotals);
ds_map_destroy(recoverFrameTotals); recoverFrameTotals = -1;

ds_map_destroy(handItems); handItems = -1;
ds_map_destroy(equippedLimbItems); equippedLimbItems = -1;

ds_map_destroy(conditionPercentages); conditionPercentages = -1;
ds_map_destroy(conditionLevels); conditionLevels = -1;