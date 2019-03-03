event_inherited();

/*
draw_set_alpha(1);
draw_set_color(c_aqua);
draw_path(path,x,y,1);
draw_set_color(c_lime);
draw_path(gridPath,x,y,1);


if ds_list_size(guessPathPts) > 0 {
	
	draw_set_color(c_orange);
	draw_circle(tempTargetX, tempTargetY, 10, 0);
	
	draw_set_color(c_white);
	draw_text(tempTargetX, tempTargetY, "tt");
		
	draw_text(tempTargetX,tempTargetY+15, "(" + string(tempTargetX) + ", " + string(tempTargetY) + ")");
	
	// draw each guessPt
	for (var i = 0; i < ds_list_size(guessPathPts); i++) {
	
		var guessPathPt = ds_list_find_value(guessPathPts, i);
		var gx = guessPathPt[0];
		var gy = guessPathPt[1];
	
		draw_set_color(c_purple);
		draw_circle(gx, gy, 10, 0);
	
		draw_set_color(c_white);
		draw_text(gx, gy, string(i));
		
		draw_text(gx,gy+15, "(" + string(gx) + ", " + string(gy) + ")");

	}
}



draw_set_alpha(.15);
mp_grid_draw(personalGrid);