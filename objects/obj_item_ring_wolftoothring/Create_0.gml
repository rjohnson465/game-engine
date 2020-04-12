/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

type = ItemTypes.Ring;

isStackable = false;
name = "Wolf Tooth Ring";
baseName = "Wolf Tooth Ring";
spriteName = "wolftoothring";
// get random item sprite, based on act
itemSprite = spr_item_wolftoothring;
// for saving / loading cosistently
itemSpriteName = sprite_get_name(itemSprite);

soundDrop = snd_item_ring;

isItemNameStatic = true;

isSpecialRing = true;

description = "A small metal band lined with the teeth of wolves. When a wolf is backed into a corner, he fights even harder. Wear to gain attack power when your health is low.";