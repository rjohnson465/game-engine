event_inherited();

if hasSetAlarm && instance_exists(lightRadius) {
	instance_destroy(lightRadius); lightRadius = -1;
}

// 1 in 3 chance to get a lamplight?
randomize();
var rand = round(random_range(0,3));
if rand == 1 {
	var droppedItems = ds_list_create();
	ds_list_add(droppedItems, instance_create_depth(x, y, 1, obj_item_lamplight));
	var drop = makeItemDrop(droppedItems);
	drop.x = x;
	drop.y = y;
}