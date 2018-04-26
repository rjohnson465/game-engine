var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

if distance_to_object(obj_player) < 20 && layer == global.player.layer && interactInputReceived && global.player.isAlive && !global.isLooting {
	isBeingLooted = true;
} 
else if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.isLooting {
	global.canLoot = true;
}
else if distance_to_object(obj_player) >= 20 {
	isBeingLooted  = false;
	global.canLoot = false;
}

// ensure items are not anywhere on screen if not being looted
if (!isBeingLooted && items) || (distance_to_object(obj_player) > 20 && items)  {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		item.x1 = -100;
		item.y1 = -100;
	}
	global.isLooting = false;
} else global.isLooting = true;

if items && (ds_list_size(items) == 0 && !hasSetAlarm) {
	alarm[0]=3;
	hasSetAlarm = true;
}

if global.ui.isShowingMenus isBeingLooted = false;

// particles
if layer >= global.player.layer {
	part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, 1);
}