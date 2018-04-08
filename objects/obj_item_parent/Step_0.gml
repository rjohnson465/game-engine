event_inherited();

if count < 1 && object_index != obj_item_coins {
	if ds_list_find_index(global.player.inventory,id) != -1 {
		ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,id));
	}
	instance_destroy(id);
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
	cursor_sprite = itemSprite;
	visible = true;
	x = mouse_x;
	y = mouse_y;
	global.ui.grabbedItem = id;
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



