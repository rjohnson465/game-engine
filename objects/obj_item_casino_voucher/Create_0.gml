/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Casino Voucher"
spriteName = "casino_voucher";
itemSprite = spr_item_casino_voucher;
keySpriteIndexName = sprite_get_name(itemSprite);

type = ItemTypes.Key;

isStackable = false;
isUsable = false;

description = "A glowing review David and Santa co-wrote for me to get into the Olive Branch Casino, north of Winter Wonderground. Let's go waste some money.";
isSellable = false;
isDestroyable = false;

soundDrop = snd_item_paper;