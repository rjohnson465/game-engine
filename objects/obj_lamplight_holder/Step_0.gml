event_inherited();

// drop item the second you're killed
if hasSetAlarm && !hasDroppedItem {
	// 1 in 4 chance to get a lamplight?
	randomize();
	var rand = round(random_range(0, 4));
	if rand == 1 {
		var droppedItems = ds_list_create();
		ds_list_add(droppedItems, instance_create_depth(x, y, 1, obj_item_lamplight));
		var drop = makeItemDrop(droppedItems);
		drop.x = x;
		drop.y = y;
	}
	hasDroppedItem = true;
}

if hasSetAlarm && instance_exists(lightRadius) {
	with lightRadius {
		var alpha = 1 - (1/other.fadeLightFrame);
		if other.fadeLightFrame < 0 {
			alpha = 0;
		}
		light_set_alpha(alpha);
		other.fadeLightFrame--;
	}
}