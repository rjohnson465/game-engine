if id == global.ui.grabbedItem {
	var gw = window_get_width();
	var gh = window_get_height();
	var vw = view_get_wport(view_camera[0]);
	var vh = view_get_hport(view_camera[0]);
	var xs = gw/vw; var ys = gh/vh;
	
	var xs = 1; var ys = 1;
	
	window_set_cursor(cr_none);
	
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	//draw_sprite_ext(spr_item_slot,1,mouse_x-vx-32,mouse_y-vy-32,xs,ys,0,c_white,1);
	draw_sprite_ext(itemSprite,1,mouse_x-vx-32,mouse_y-vy-32,xs,ys,0,c_white,1);
	
	//	show_debug_message(string(gw) + "," + string(gh));
}