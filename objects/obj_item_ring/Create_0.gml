/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

type = ItemTypes.Ring;

isStackable = false;
name = "Ring";
baseName = "Ring";
spriteName = "ring";
// get random item sprite, based on act
itemSprite = noone;


switch act {
	case 1: {
		var options = [spr_item_ring_1_1, spr_item_ring_1_2, spr_item_ring_1_3];
		randomize();
		var rand = round(random_range(0, array_length_1d(options)-1));
		itemSprite = options[rand];
		break;
	}
}
// for saving / loading cosistently
itemSpriteName = sprite_get_name(itemSprite);

soundDrop = snd_item_ring;

isSpecialRing = false;