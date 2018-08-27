/// enemyGenClearHandItems()
/// static function -- clear the memory used to hold the current hand items
/// this is usually done before assigning new items to those hands

// destroy all hand items
var ck = ds_map_find_first(handItems);
for (var i = 0; i < ds_map_size(handItems); i++) {
	var item = ds_map_find_value(handItems,ck);
	instance_destroy(item,1);
	ck = ds_map_find_next(handItems,ck);
}
ds_map_clear(handItems);

// clear all equippedItems
ds_map_clear(equippedLimbItems);