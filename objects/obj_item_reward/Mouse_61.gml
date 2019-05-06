var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if	point_in_rectangle(mouse_x,mouse_y,vx+invTopLeftX,vy+invTopLeftY,vx+invBottomRightX,vy+invBottomRightY) {
	//var inv = global.player.inventory;
	// do not keep scrolling down if last shown row contains last item in player inventory
	if !is_undefined(ds_list_find_value(inv, 19 + (5*scrollLevel))) {
		scrollLevel++;
	}
}