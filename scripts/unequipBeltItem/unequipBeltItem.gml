/// equipBeltItem(beltItemIndex)
/// @param beltItemIndex

var index = argument[0];

var p = global.player;

// if this item is already in the belt, remove it from its old index before assigning it to the new one
var item = p.beltItems[index];
if item == noone || item == undefined || !instance_exists(item) exit;

p.beltItems[index] = noone;
item.beltItemIndex = noone;


// maybe?
audio_play_sound(snd_ui_click1, 1, 0);