var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// if within inventory region and inventory menu is up
if	(mouse_x > vx + 212 && mouse_x < vx + 562) 
	&& (mouse_y > vy + 184 && mouse_y < vy + 400)  
	&& currentMenu == INVENTORY && inventoryScrollLevel != 0 {
	inventoryScrollLevel --;
}