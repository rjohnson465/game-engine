/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

type = ItemTypes.Ring;

isStackable = false;
name = "Ari's Clay Ring";
baseName = "Ari's Clay Ring";
spriteName = "clayring";
// get random item sprite, based on act
itemSprite = spr_item_clayring;

soundDrop = snd_item_ring;

isItemNameStatic = true;

addItemProperty(id, ModifiableProperties.ElementalDamageTypesMultiplier, [FIRE, 30]);
addItemProperty(id, ModifiableProperties.Defenses, [FIRE, 25]);