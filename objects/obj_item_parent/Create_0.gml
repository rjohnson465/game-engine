owner = noone;
x1 = -50;
y1 = -50;
sprite_index = spr_item_slot;
visible = false;
depth = -1001;
persistent = true;
name = "default item name";
baseName = "default item base name";

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
isSellable = true;
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

numberOfSockets = 0;
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
	GoldDrop,
	length
}

itemProperties = ds_map_create();

hasIssuedDurabilityWarning = false;
hasIssuedDurabilityObituary = false;

durability = 50;
durabilityMax = 50;

charges = 0;
chargesMax = 0;

ammo = 0;
ammoMax = 0;

invIndex = noone;

didClickStartInInventory = false;
didClickStartInEquipment = false;
equipmentSlotBeforeDrag = noone;

isTwoHanded = false;
soundGrab = snd_item_pickup;
soundDrop = snd_item_pickup;
soundUse = snd_item_gem; 