if global.fountainGui.currentSubMenu != CHOOSEITEM exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if	point_in_rectangle(mouse_x,mouse_y,vx+invTopLeftX,vy+invTopLeftY,vx+invBottomRightX,vy+invBottomRightY) {
	//var inv = global.player.inventory;
	if scrollLevel != 0 {
		scrollLevel--;
	}
}
