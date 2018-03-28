x1 = -50;
y1 = -50;
sprite_index = spr_item_slot;
visible = false;
depth = -2;
//persistent = true;
name = "";

copyOf = noone;

enum ItemTypes {	
	HandItem,
	Ring,
	Head,
	Other
}

type = ItemTypes.HandItem;
subType = noone;

spriteName = "";
itemSprite = "";
value = 0;
description = "Sample description";

isStackable = true;
count = 1;
isUsable = false;
isInUse = false;

// only for hand items, head items, and ring items
acceptableEquipmentSlots = [];

//isEquipped = false;
equippedItemsManager = global.equippedItemsManager;
equipmentSlot = noone;

mightGrab = false;
grabFrame = 0;
grabFrames = 1;

enum ItemProperties {
	HpMax,
	HpRegen,
	StaminaMax,
	StaminaRegen
}

itemProperties = ds_map_create();
numberOfSockets = 0;