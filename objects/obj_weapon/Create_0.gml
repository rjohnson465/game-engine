limb = global.limb;
limbKey = limb.limbKey;
owner = limb.owner;
handItem = limb.handItem;

spriteString = "spr_"+owner.spriteString+"_"+limb.handItem.spriteName;
//frame = -1;
sprite_index = asset_get_index(spriteString);


if limbKey == "l" {
	image_yscale = -1;
}

// particle system for elemental effects
emitter = noone;
system = noone;
particle = noone;