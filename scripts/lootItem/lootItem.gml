/// lootItem(item, dropObj)
/// @param item
/// @param dropObj

var item = argument[0];
var dropItem = argument[1];

if !instance_exists(item) exit;
if !instance_exists(dropItem) exit;
if !ds_exists(dropItem.items,ds_type_list) exit;

var itemPos = ds_list_find_index(dropItem.items,item.id);
with item {
	
	if (addItemToInventory(id)) {
		audio_play_sound(soundDrop,1,0);
		ds_list_delete(dropItem.items,itemPos);
		if ds_list_size(dropItem.items) > 0 {
			dropItem.selectedItem = ds_list_find_value(dropItem.items,0);
		} else {
			dropItem.alarm[0] = 3;
		}
	}
}