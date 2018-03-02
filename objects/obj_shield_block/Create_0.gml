owner = global.owner;
side = "r"; // by default, shields can only be equipped in right hand
image_yscale = 1;
image_angle = owner.facingDirection+90;
spriteName = owner.rightHandItem.spriteName;
sprite_index = asset_get_index("spr_"+owner.spriteString+"_"+spriteName);