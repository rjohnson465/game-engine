x1 = -50;
y1 = -50;
sprite_index = spr_item_slot;
visible = false;
//depth = -2;
depth = -1001;
persistent = true;
name = "";

copyOf = noone;

enum ItemTypes {	
	HandItem,
	Ring,
	Head,
	Other
}

enum ItemRarities {
	Normal,
	Fine,
	Masterwork,
	Legendary
}

rarity = ItemRarities.Normal;

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

socketedGems = ds_list_create();

enum ModifiableProperties {
	HpMax,
	HpRegen,
	StaminaMax,
	StaminaRegen,
	CriticalsDamage,
	CriticalsChance,
	WeaponTypesDamage,
	PhysicalDamageTypesMultiplier, // Rarer than elemental damage types multiplier
	ElementalDamageTypesMultiplier,
	OffHandDamage,
	Poise,
	Defenses,
	XpMultiplier,
	HpSteal,
	StaminaSteal,
	length
}

itemProperties = ds_map_create();
numberOfSockets = 0;

hasIssuedDurabilityWarning = false;
hasIssuedDurabilityObituary = false;