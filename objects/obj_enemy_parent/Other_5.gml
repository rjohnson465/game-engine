event_inherited();

ds_list_destroy(droppedItems);
ds_list_destroy(beenHitWith);

ds_map_destroy(preparingLimbs);
ds_map_destroy(attackingLimbs);
ds_map_destroy(recoveringLimbs);
ds_map_destroy(prepFrames);
ds_map_destroy(attackFrames);
ds_map_destroy(recoverFrames);
ds_map_destroy(prepFrameTotals);
//ds_map_destroy(attackFrameTotals);
ds_map_destroy(recoverFrameTotals);

ds_map_destroy(handItems);
ds_map_destroy(equippedLimbItems);

ds_map_destroy(conditionPercentages);
ds_map_destroy(conditionLevels);