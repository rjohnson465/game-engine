/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = global.keyName;
spriteName = global.keySpriteName;
itemSprite = global.keySpriteIndex;

type = ItemTypes.Key;

isStackable = false;
isUsable = false;

description = global.keyDescription;
isSellable = false;
isDestroyable = false;

soundDrop = snd_item_ring;