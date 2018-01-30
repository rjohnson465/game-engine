hand = global.hand;
handSide = hand.handSide;
owner = hand.owner;

spriteString = "spr_"+owner.spriteString+"_"+hand.handItem.spriteName;
frame = -1;
sprite_index = asset_get_index(spriteString);