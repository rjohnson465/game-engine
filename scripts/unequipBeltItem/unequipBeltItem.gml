/// equipBeltItem(beltItemIndex)
/// @param beltItemIndex

var index = argument[0];

var p = global.player;

// if this item is already in the belt, remove it from its old index before assigning it to the new one
var item = p.beltItems[index];
if item == noone || item == undefined || !instance_exists(item) exit;

p.beltItems[index] = noone;
item.beltItemIndex = noone;

// if we just unequipped our current belt item, change current belt item to something else, if possible
if p.currentBeltItemIndex == index {
	for (var i = 0; i < array_length_1d(p.beltItems); i++) {
		var bi = p.beltItems[i];
		if bi != noone && instance_exists(bi) {
			p.currentBeltItemIndex = i;
		}
	}
}


// maybe?
audio_play_sound(snd_ui_click1, 1, 0);