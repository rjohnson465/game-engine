/*// range attack finish / recover
// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
// set recoverFrames to -1
ds_map_replace(owner.recoverFrames,limbKey,-1);
		
// remove limbKey from attackingLimbs map
ds_map_delete(owner.attackingLimbs,limbKey);