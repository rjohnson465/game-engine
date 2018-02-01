limb = global.limb;
limbKey = limb.limbKey;
owner = limb.owner;
handItem = limb.handItem;

spriteString = "spr_"+owner.spriteString+"_"+limb.handItem.spriteName;
//frame = -1;
sprite_index = asset_get_index(spriteString);