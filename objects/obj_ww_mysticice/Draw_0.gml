//prepareLayerShader();
if !isOpen {
	draw_sprite_ext(sprite_index,1,x,y,xscale,yscale,angle,c_white,1);
} else {
	// TODO drawn melted?
	if alarm[0] > 0 {
		
		// at max frames, draw scale 1
		// at min frames, draw scale 0
		var scale = (1/MELT_FRAMES_TOTAL)*alarm[0];
		
		// at max frames, draw opacity 1
		// at min frames, draw opacity 0 
		var alpha = (1/MELT_FRAMES_TOTAL)*alarm[0];
		
		draw_sprite_ext(spr_ww_mysticice, 1, x, y, scale*xscale, scale*yscale, angle, c_white, alpha);
	}
}
shader_reset();