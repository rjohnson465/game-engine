limb = global.limb;
limbKey = limb.limbKey;
owner = limb.owner;
limbItem = limb.limbItem;

spriteString = "spr_"+owner.spriteString+"_"+limbItem.spriteName;
sprite_index = asset_get_index(spriteString);


if limbKey == "l" {
	image_yscale = -1;
}

// particle system for elemental effects
emitter = noone;
system = noone;
particle = noone;