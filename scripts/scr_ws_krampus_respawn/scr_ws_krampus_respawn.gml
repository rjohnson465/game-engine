/// scr_ws_krampus_respawn

// deactivate all icebridges in room
with obj_ww_icebridge {
	isActive = false;
	image_xscale = 0; image_yscale = 0;
	light_set_alpha(0);
}