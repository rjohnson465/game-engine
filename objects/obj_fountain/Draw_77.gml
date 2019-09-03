if alarm[0] <= 0 exit;
// ripple effect when lit
var_time_var+=0.04;
shader_set(shd_radial_blur);
	var sw = window_get_width();
	var sh = window_get_height();
    shader_set_uniform_f(uni_time, var_time_var);
	var_mouse_pos_x = x - camera_get_view_x(0);
	var_mouse_pos_y = y - camera_get_view_y(0);

    shader_set_uniform_f(uni_mouse_pos, var_mouse_pos_x, var_mouse_pos_y);
    shader_set_uniform_f(uni_resolution, var_resolution_x, var_resolution_y);
    shader_set_uniform_f(uni_radial_blur_offset, var_radial_blur_offset);
    shader_set_uniform_f(uni_radial_brightness, var_radial_brightness);

	
	
	var vh = var_resolution_y;
	var vw = var_resolution_x;
	
	// stretched width
	var stw = vw*(sh/vh);
	
	var dw = display_get_width();
	var dh = display_get_height();
	
	// view point x
	var vpx = (sw/2)-(stw/2);
	
	if window_get_fullscreen() {
		stw = vw*(dh/vh);
		vpx = (dw / 2) - (stw/2);
		sh = dh;
	}
	
	draw_surface_stretched(application_surface,vpx,0,stw,sh);
    //if full_screen_effect draw_surface(surf,0,0);
shader_reset();

