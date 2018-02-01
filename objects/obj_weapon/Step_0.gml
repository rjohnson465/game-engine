x = limb.x;
y = limb.y;
image_angle = owner.facingDirection;

if ds_map_find_value(owner.prepFrames,limbKey) > 0 {
	var attackNumber = ds_map_find_value(owner.preparingLimbs,limbKey);
	//image_index = 0;
	sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
}
