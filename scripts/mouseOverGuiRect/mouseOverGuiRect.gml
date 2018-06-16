/// mouseOverGuiRect(x1,y1,x2,y2)
/// @param x1
/// @param y1
/// @param x2
/// @param y2

/// must be called in a GUI event
/// check if mouse_x / mouse_y are in a region

var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

return point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.gamePadIndex);