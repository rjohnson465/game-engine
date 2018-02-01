if ds_map_find_value(owner.attackingLimbs,limbKey) > 0 {
	var attackNumber = ds_map_find_value(owner.attackingLimbs,limbKey);
	image_index = 0;
	sprite_index = asset_get_index(spriteString+"_attack_"+string(attackNumber));
} 
else if ds_map_find_value(owner.recoveringLimbs,limbKey) > 0 {
	var attackNumber = ds_map_find_value(owner.recoveringLimbs,limbKey);
	image_index = 0;
	sprite_index = asset_get_index(spriteString+"_recover_"+string(attackNumber));
} else {
	sprite_index = asset_get_index(spriteString);
}

