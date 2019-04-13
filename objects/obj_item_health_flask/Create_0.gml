/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Health Flask";
spriteName = "health_flask";
itemSprite = spr_item_health_flask_full;
soundUse = snd_iu_drink_potion;

isDestroyable = false;

// health flask strings (hfs) macros
#macro hfs_charges "charges"
#macro hfs_charge_strength "chargeStrength"
#macro hfs_max_charges "maxCharges"

ds_map_replace(customItemProperties, hfs_charges, 3);
ds_map_replace(customItemProperties, hfs_max_charges, 3);
ds_map_replace(customItemProperties, hfs_charge_strength, 50);

type = ItemTypes.Other;

isStackable = false;
isUsable = true;

// description varies based on stats
updateHealthFlaskDescription();
