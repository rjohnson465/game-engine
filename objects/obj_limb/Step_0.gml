// if we currently have a 2h weapon equipped, make the left hand fuck off
var rightHandItem = ds_map_find_value(owner.equippedLimbItems,"r");
if rightHandItem {
	if rightHandItem.isTwoHanded && limbKey == "l" {
		x = -10;
		y = -10;
	}
}

x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;

if ds_map_find_value(owner.preparingLimbs,limbKey) > 0 {
	var attackNumber = ds_map_find_value(owner.preparingLimbs,limbKey);
	sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
}

// TODO
// change hand item spriteString based on changed weapons
// do this here? Or when something is equipped / unequipped?




