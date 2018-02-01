/*leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);*/

if lockOnTarget == noone {
	isLockedOn = false;
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

isMouseInMenu = global.ui.isShowingMenus &&
	mouse_x > vx + MENUS_TOPLEFT_X && mouse_x < vx + MENUS_BOTTOMRIGHT_X &&
	mouse_y > vy + MENUS_TOPLEFT_Y && mouse_y < vy + MENUS_BOTTOMRIGHT_Y;