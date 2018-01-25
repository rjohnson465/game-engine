/*var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if	(mouse_x > vx + 212 && mouse_x < vx + 562) 
	&& (mouse_y > vy + 184 && mouse_y < vy + 400)  
	&& currentMenu == INVENTORY {
	var inv = global.player.inventory;
	// do not keep scrolling down if last shown row contains last item in player inventory
	if !is_undefined(ds_list_find_value(inv, 19 + (5*global.ui.inventoryScrollLevel))) {
		inventoryScrollLevel++;
	}
}