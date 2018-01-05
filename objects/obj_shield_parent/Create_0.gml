owner = global.owner;
side = "l"; // by default, shields can only be equipped in left hand
image_yscale = -1;
image_angle = owner.facingDirection-90;
spriteName = owner.leftHandItem.spriteName;
sprite_index = asset_get_index("spr_"+owner.spriteString+"_"+spriteName);