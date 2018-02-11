//instance_activate_all()
//instance_deactivate_region(view_xview[view_current] - 512, view_yview[view_current] - 512, view_wview[view_current] + 512 * 2, view_hview[view_current] + 512 * 2, false, true)

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

light_draw(vx,vy, true, true, blur)