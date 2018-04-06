/// makeItemDrop(droppedItems)
/// @param droppedItems ds_list

var droppedItems = argument[0];

// ensure no noone refs in droppedItems
for (var i = 0; i < ds_list_size(droppedItems); i++) {
	var item = ds_list_find_value(droppedItems,i);
	if item == noone || item == undefined ds_list_delete(droppedItems,i);
}

if ds_list_size(droppedItems) == 0 return noone;

global.droppedItems = droppedItems;
global.owner = id;

return instance_create_depth(x,y,1,obj_item_drop);