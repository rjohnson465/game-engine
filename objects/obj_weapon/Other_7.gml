if ds_map_find_value(owner.attackingHands,handSide) > 0 {
	var attackNumber = ds_map_find_value(owner.attackingHands,handSide);
	sprite_index = asset_get_index(spriteString+"_attack_"+string(attackNumber));
} 
else if ds_map_find_value(owner.recoveringHands,handSide) > 0 {
	var attackNumber = ds_map_find_value(owner.recoveringHands,handSide);
	sprite_index = asset_get_index(spriteString+"_recover_"+string(attackNumber));
} 
else sprite_index = asset_get_index(spriteString);