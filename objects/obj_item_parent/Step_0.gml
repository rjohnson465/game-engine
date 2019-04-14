event_inherited();

if value == 0 && baseValue != 0 {
	appraiseItem(id);
}

// destroy empty stacks
if count < 1 && object_index != obj_item_coins {
	if ds_list_find_index(global.player.inventory,id) != -1 {
		ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,id));
	}
	instance_destroy(id);
}

// if being used, decrement count or destroy item. update inventory capacity
if isInUse {
	if count > 1 && isStackable {
		count--;
	} else if isStackable {
		
		var itemType = getItemFilterType(id);
		var currentItemTypeCount = ds_map_find_value(global.player.inventoryCapacityMap, itemType);
		ds_map_replace(global.player.inventoryCapacityMap, itemType, currentItemTypeCount - 1);
		
		instance_destroy(id);
		if ds_list_find_index(global.player.inventory,id) != -1 {
			ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,id));
		}
	}
}


if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

if !position_meeting(mouse_x,mouse_y,id) && grabFrame < grabFrames {
	grabFrame = 0;
	mightGrab = false;
}

if mightGrab && grabFrame < grabFrames && mouse_check_button(mb_left) {
	grabFrame++;
}

visible = false;
if grabFrame == grabFrames {
	visible = true;
	x = mouse_x;
	y = mouse_y;
	if global.ui.grabbedItem != id {
		audio_play_sound(soundGrab,1,0);
	}
	global.ui.grabbedItem = id;
	isGrabbed = true;
	if isUsable {
		global.player.isEquippingBeltItem = true;
	}
} else {
	window_set_cursor(cr_default);
}

if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY {
	visible = false;
}

// if dragged over equipped items area, set the acceptable items array
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var eim = global.equippedItemsManager;
if point_in_rectangle(mouse_x,mouse_y,vx+eim.topLeftX,vy+eim.topLeftY,vx+eim.bottomRightX,vy+eim.bottomRightY) {
	acceptableEquipmentSlots = getAcceptableEquipmentSlots(id);
} else {
	acceptableEquipmentSlots = [];
}


