/// equipBeltItem(beltItemIndex, item)
/// @param beltItemIndex
/// @param item

var index = argument[0];
var item = argument[1];

var p = global.player;

// if this item is already in the belt, remove it from its old index before assigning it to the new one
for (var i = 0; i < array_length_1d(p.beltItems); i++) {
	var bi = p.beltItems[i];
	if bi != noone && bi != undefined && instance_exists(bi) && object_is_ancestor(bi.object_index, obj_item_parent) {
		if bi == item {
			bi.beltItemIndex = noone;
			p.beltItems[i] = noone;
		}
	}
}

// unequip whatever item used to be at that belt index
with obj_item_parent {
	if id != item && beltItemIndex == index {
		unequipItem(id);
		beltItemIndex = noone;
	}
}

p.beltItems[index] = item;
item.beltItemIndex = index;
audio_play_sound(snd_ui_click1, 1, 0);


// if this is the only belt item, make it the current belt item
var currentBeltItem = p.beltItems[p.currentBeltItemIndex];
if !instance_exists(currentBeltItem) {
	p.currentBeltItemIndex = index;
}

p.isEquippingBeltItem = false;