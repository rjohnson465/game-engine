/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

type = ItemTypes.Ring;

name = "Ring";
spriteName = "ring";
itemSprite = spr_item_ring1;

//ds_map_replace(itemProperties,ModifiableProperties.XpMultiplier,10);
//ds_map_replace(itemProperties,ModifiableProperties.Defenses,[MAGIC,1]);
ds_map_replace(itemProperties,ModifiableProperties.ElementalDamageTypesMultiplier,[MAGIC,100]);