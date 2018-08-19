owner = noone;
x1 = -50;
y1 = -50;
sprite_index = spr_item_slot;
visible = false;
depth = -1001;
persistent = true;
name = "default item name";
baseName = "default item base name";
baseNameModified = baseName;
gemmedName = "default item gemmed name";

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
baseValue = 0;
isSellable = true;
description = "Sample description";

isStackable = true;
count = 1;
isUsable = false;
isInUse = false;

isDestroyable = true;

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

enum WeaponProperties {
	PhysicalDamageBonus,
	ElementalDamageBonus,
	DurabilityAmmoBonus, // one or the other
	ChargesBonus,
	length
}

// THE ORDER THESE ARE DECLARED IN MATTERS!!!q         
enum ShieldProperties {
	PhysicalBlockBonus,
	ElementalBlockBonus,
	DurabilityBonus,
	length
}

enum HatProperties {
	SlashDefenseBonus,
	CrushDefenseBonus,
	PierceDefenseBonus,
	ElementalDefenseBonus,
	length
}

// if an item has inherent base props modified, these properties hold a "property score"
// this score represents how much the property was modified from its base value
// the value will put the modified property in a tier of 1-3
global.basePropModTiers = [10, 30, 30, 45, 45, 60];


itemProperties = ds_map_create(); // rings -- hold additional properties
itemPropertyModifiers = ds_map_create(); // non-rings -- holds item-specific prop mods that affect base prop vals

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

itemDropObj = noone;

// "points" -- a standardized unit -- added to modify the item (used by Rings to assess value)
_pts = 0;
_ptsSpent = 0;