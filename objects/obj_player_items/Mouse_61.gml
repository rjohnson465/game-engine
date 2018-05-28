var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if	//point_in_rectangle(mouse_x,mouse_y,vx+invTopLeftX,vy+invTopLeftY,vx+invBottomRightX,vy+invBottomRightY) 
	mouseOverGuiRect(invTopLeftX,invTopLeftY,invBottomRightX,invBottomRightY) {
	// do not keep scrolling down if last shown row contains last item in player inventory
	//var lastItem = ds_list_find_value(items,ds_list_size(items)-1);
	if !is_undefined(ds_list_find_value(inv, 20 + (5*scrollLevel))) {
	//if ds_list_find_index(inv,lastItem) == -1 {
		scrollLevel++;
	}
}