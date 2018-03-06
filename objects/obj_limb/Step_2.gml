if owner.state == CombatantStates.Dodging {
	visible = false;
} else visible = true;

// switch hand sprites if weapon changes and uses different weapon art
if ds_map_find_value(owner.equippedLimbItems,limbKey) != limbItem {
	limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
	
	if owner.type != CombatantTypes.Player {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
	} else {
		spriteString = limbItem.handSpriteString;
	}
	
	sprite_index = asset_get_index(spriteString);
}

// if we currently have a 2h weapon equipped, make the right hand fuck off
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
if leftHandItem {
	if leftHandItem.isTwoHanded && limbKey == "r" {
		x = -1000;
		y = -1000;
	} else {
		x = owner.x;
		y = owner.y;
	}
}
image_angle = owner.facingDirection;
image_alpha = owner.alpha;

if limbItem.subType == HandItemTypes.Shield && owner.isShielding {
	image_angle = owner.facingDirection+90;
} else image_angle = owner.facingDirection;

if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.prepFrames,limbKey);
	sprite_index = getLimbSpriteIndex("prep");
}

else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.attackFrames,limbKey);
	sprite_index = getLimbSpriteIndex("attack");
}

else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.recoverFrames,limbKey);
	sprite_index = getLimbSpriteIndex("recover");
} 
else {
	sprite_index = asset_get_index(spriteString);
}
/*
if owner.type != CombatantTypes.Player && sprite_index != asset_get_index(spriteString) {
	show_debug_message(string(sprite_index) + string(image_index));
}



