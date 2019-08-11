shader_set(shd_greyscale);
    shader_set_uniform_f(uni_greyscale_fade, var_greyscale_fade);
	
	var sw = window_get_width();
	var sh = window_get_height();
	
	var dw = display_get_width();
	var dh = display_get_height();
	
	var vh = var_resolution_y;
	var vw = var_resolution_x;
	
	// stretched width
	var stw = vw*(sh/vh);
	// view point x
	var vpx = (sw/2)-(stw/2);
	
	if window_get_fullscreen() {
		stw = vw*(dh/vh);
		vpx = (dw / 2) - (stw/2);
		sh = dh;
	}
	
    draw_surface_stretched(application_surface,vpx,0,stw,sh);
shader_reset();

