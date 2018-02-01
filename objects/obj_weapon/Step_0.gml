x = limb.x;
y = limb.y;
image_angle = owner.facingDirection;

// switch weapon sprite
if handItem != limb.handItem {
	handItem = limb.handItem;
	spriteString = "spr_"+owner.spriteString+"_"+limb.handItem.spriteName;
	sprite_index = asset_get_index(spriteString);
	
}

if handItem.weaponType {
	if handItem.weaponType == WeaponTypes.Unarmed {
		visible = false;
	} else visible = true;
}

if ds_map_find_value(owner.prepFrames,limbKey) > 0 {
	var attackNumber = ds_map_find_value(owner.preparingLimbs,limbKey);
	sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
}
