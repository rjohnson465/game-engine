owner = global.owner;
if owner == global.player solid = true;
side = "r"; // by default, shields can only be equipped in right hand
image_yscale = 1;
//image_angle = owner.facingDirection+90;
//shield = ds_map_find_value(owner.equippedLimbItems,"r");
shield = noone;
var ck = ds_map_find_first(owner.equippedLimbItems);
for (var i = 0; i < ds_map_size(owner.equippedLimbItems); i++) {
	var item = ds_map_find_value(owner.equippedLimbItems, ck);
	if item.subType == HandItemTypes.Shield {
		shield = item;
		break;
	}
	ck = ds_map_find_next(owner.equippedLimbItems, ck);
}
spriteName = shield.spriteName;
sprite_index = asset_get_index("spr_"+owner.spriteString+"_"+spriteName+"_block");