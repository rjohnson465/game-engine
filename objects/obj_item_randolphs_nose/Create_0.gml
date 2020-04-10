/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Randolph's Nose"
spriteName = "randolphs_nose";
itemSprite = spr_item_randolphs_nose;
keySpriteIndexName = sprite_get_name(itemSprite);

type = ItemTypes.Key;

isStackable = false;
isUsable = false;

description = "The glowing nose of Randolph, the Red-Nosed Reindeer. Not to be confused with any other red-nosed reindeer. Can be used to melt Mystic Ice.";
isSellable = false;
isDestroyable = false;

soundDrop = snd_item_pickup;