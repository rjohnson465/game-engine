x1 = -50;
y1 = -50;
sprite_index = spr_item_slot;
visible = false;
depth = -2;
persistent = true;
name = "";

copyOf = noone;

enum ItemTypes {	
	HandItem,
	Ring,
	Other
}

type = ItemTypes.HandItem;
subType = noone;

spriteName = "";
itemSprite = "";
value = 0;
description = "Sample description";

//cloneOf = noone;

//isEquipped = false;
equippedItemsManager = global.equippedItemsManager;
equipmentSlot = noone;

mightGrab = false;
grabFrame = 0;
grabFrames = 1;