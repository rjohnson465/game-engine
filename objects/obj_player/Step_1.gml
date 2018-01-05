leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
isMouseInMenu = mouse_x > vx + 112 && mouse_x < vx + 912 
				&& mouse_y > vy + 134 && mouse_y < vy + 634
				&& global.ui.isShowingMenus;

if lockOnTarget == noone {
	isLockedOn = false;
}
