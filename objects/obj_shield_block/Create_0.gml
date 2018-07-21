owner = global.owner;
if owner == global.player solid = true;
side = "r"; // by default, shields can only be equipped in right hand
image_yscale = 1;
//image_angle = owner.facingDirection+90;
shield = ds_map_find_value(owner.equippedLimbItems,"r");
spriteName = shield.spriteName;
sprite_index = asset_get_index("spr_"+owner.spriteString+"_"+spriteName+"_block");