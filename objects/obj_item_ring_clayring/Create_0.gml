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
// for saving / loading cosistently
itemSpriteName = sprite_get_name(itemSprite);

soundDrop = snd_item_ring;

isItemNameStatic = true;

isSpecialRing = true;

description = "Imbued with the magic of clay, Ari's old ring, once belonging to his wife, grants its wearer significant fire defense, and boosts fire attacks.";

addItemProperty(id, ModifiableProperties.ElementalDamageTypesMultiplier, [FIRE, 30]);
addItemProperty(id, ModifiableProperties.Defenses, [FIRE, 25]);