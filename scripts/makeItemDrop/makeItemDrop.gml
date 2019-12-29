/// makeItemDrop(droppedItems, *x, *y, *layer)
/// @param droppedItems ds_list
/// @param x
/// @param y
/// @param layer

var droppedItems = argument[0];

// ensure no noone refs in droppedItems
for (var i = 0; i < ds_list_size(droppedItems); i++) {
	var item = ds_list_find_value(droppedItems,i);
	if item == noone || item == undefined ds_list_delete(droppedItems,i);
	else {
		item.persistent = true;
	}
}

if ds_list_size(droppedItems) == 0 return noone;

global.droppedItems = droppedItems;
global.owner = id;

var xx = x; var yy = y; 
if argument_count > 1 {
	xx = argument[1];
}
if argument_count > 2 {
	yy = argument[2];
}
if argument_count > 3 {
	var lay = argument[3];
	global.owner = global.player; // i guess??
	return instance_create_layer(xx, yy, lay, obj_item_drop);
}
return instance_create_depth(xx,yy,1,obj_item_drop);