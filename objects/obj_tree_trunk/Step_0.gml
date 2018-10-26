var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-100,vy-100,vx+vw+100,vy+vh+100) exit; 
if layer != global.player.layer {
	layer = global.player.layer;
	// Make a circle with 16 points.
	var n = 16
	var gap = 360 / n;
	var pointsx = ds_list_create()
	var pointsy = ds_list_create()
	var sw = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index);
	var sh = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index);
	for (var i = 0; i < n; i++) {
		ds_list_add(pointsx, lengthdir_x((sw/2) + 1, i * gap))
		ds_list_add(pointsy, lengthdir_y((sh/2) + 1, i * gap))
	}
	light_create_caster_from_points_layer(pointsx, pointsy)
}