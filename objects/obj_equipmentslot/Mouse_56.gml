var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
	
if	item != noone && item != undefined && item == global.ui.grabbedItem 
	&& (mouse_x > vx + global.inventory.invTopLeftX && mouse_x < vx + global.inventory.invBottomRightX) 
	&& (mouse_y > vy + global.inventory.invTopLeftY && mouse_y < vy + global.inventory.invBottomRightY) 
	&& global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY
{
	unequipItem(item);		
}