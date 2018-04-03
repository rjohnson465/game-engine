/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

type = ItemTypes.Ring;

name = "Ring";
spriteName = "ring";
itemSprite = spr_item_ring1;

ds_map_replace(itemProperties,ModifiableProperties.HpMax,10);
ds_map_replace(itemProperties,ModifiableProperties.HpRegen,1);
ds_map_replace(itemProperties,ModifiableProperties.CriticalsChance,[SWORD1H,10]);