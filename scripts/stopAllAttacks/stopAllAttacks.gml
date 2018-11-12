// stop attacking -- 
jumpFrame = jumpTotalFrames;
if true {
	// stop preparing attacks
	if ds_map_size(preparingLimbs) != 0 {
		var hand = ds_map_find_first(preparingLimbs);
		for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
			ds_map_replace(prepFrames,hand,-1);
			ds_map_replace(prepFrameTotals,hand,0);
			ds_map_delete(preparingLimbs,hand);
			hand = ds_map_find_next(preparingLimbs,hand);
		}
	}
	// stop attacking
	if ds_map_size(attackingLimbs) != 0 {
		var hand = ds_map_find_first(attackingLimbs);
		for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
			ds_map_delete(attackingLimbs,hand);
			hand = ds_map_find_next(attackingLimbs,hand);
		}
	}
	// stop recovering attacks
	if ds_map_size(recoveringLimbs) != 0 {
		var hand = ds_map_find_first(recoveringLimbs);
		for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
			ds_map_replace(recoveringLimbs,hand,-1);
			ds_map_replace(recoveringLimbs,hand,0);
			ds_map_delete(recoveringLimbs,hand);
			hand = ds_map_find_next(recoveringLimbs,hand);
		}
	}
	ds_map_clear(preparingLimbs);
	ds_map_clear(attackingLimbs);
	ds_map_clear(recoveringLimbs);
}
isStrafing = false;
currentUsingSpell = noone;
attackNumberInChain = noone;
if currentSpellPrepSound != noone {
	audio_stop_sound(currentSpellPrepSound);
	currentSpellPrepSound = noone;
}