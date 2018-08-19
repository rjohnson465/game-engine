/// destroyItem(item)
/// @param item

var item = argument[0];

alert(item.name + " destroyed",c_yellow);

if item.equipmentSlot != noone unequipItem(item);
if item.isStackable && item.count > 1 {
	item.count--;
} else {
	var pos = ds_list_find_index(global.player.inventory,item);
	ds_list_delete(global.player.inventory,pos);
	instance_destroy(item,1);
}
audio_play_sound(snd_shield_hit_metal,1,0);