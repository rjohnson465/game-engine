with player {
	if comboNumber > 0 || comboModeLevel > 0 {
		var scale = 1;
		var angle = 0;
		if comboFrame <= 10 {
			scale = (5/(comboFrame+1));
		}
		scr_draw_text_outline(20,40,comboNumber,c_purple,c_white,scale,scale,angle);
	}
	// draw the bar for combo level (and level)
	if comboModeLevel > 0 {
		// condition outline
		draw_set_alpha(.75);
		var x1 = 100-(32);
		var y1 = 100-(32)-20; 
		var x2 = 100+(32);
		var y2 = 100-(32)-15;
		scr_draw_text_outline(x2,y1,string(comboModeLevel*25+100)+"%",c_purple,c_white);
		draw_set_color(c_white);
		//draw_set_font(font_main);
		//draw_text(x2,y1,comboModeLevel);
		draw_rectangle(x1,y1,x2,y2,true);
		
		
		
		//draw_rectangle(x1,y1,x2,y2,true);
		
		// current mode level percent
		var modePercent = comboModeFrame/comboModeTotalFrames;
		//conditionPercent = conditionPercent / 100;
		var x2 = x1 + (64 * modePercent);
		if (x2 < x1) x2 = x1;
		draw_rectangle(x1,y1,x2,y2,false);
	}
}