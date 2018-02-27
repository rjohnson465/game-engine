// ensure not clicking on some gui element
var isMouseInGUI = false;
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
with obj_attunement {
	if point_in_rectangle(mouse_x,mouse_y,vx+x,vy+y,vx+vx+x+sprite_width,vy+y+sprite_height) {
		isMouseInGUI = true;
	}
}
if !isMouseInGUI {
	performLeftHandDownAction();
}