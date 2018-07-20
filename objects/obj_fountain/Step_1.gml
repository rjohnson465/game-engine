// ripple when turned on
if alarm[0] > 0 {
	var xx = abs(alarm[0]-30);
	var_radial_blur_offset = (-abs((xx-15)/30))+.5;
	//show_debug_message(var_radial_blur_offset);
}