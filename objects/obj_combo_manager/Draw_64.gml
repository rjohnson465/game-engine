with player {
	
	if comboModeLevel == 1 && (comboModeFrame / comboModeTotalFrames) < .25 {
		var totalFramesToFade = round(.25*comboModeTotalFrames);
		var frameInReference = comboModeFrame;
		draw_set_alpha((frameInReference/totalFramesToFade));
	} else if comboModeLevel == 0 && (comboFrame / comboTimeQuantum) > .75 {
		var totalFramesToFade = round(.25*comboTimeQuantum);
		var frameInReference = abs(1- (comboTimeQuantum - comboFrame));
		draw_set_alpha((frameInReference/totalFramesToFade));
	}
	
	// y1 is where to start drawing things based on whether or not attunements are visible
	var vh = view_get_hport(view_camera[0]);
	var y1 = (rightHandItem.totalCharges > 0 || leftHandItem.totalCharges > 0) ?
			vh-143 : vh-118;
	if comboEffectiveNumber > 0 || comboModeLevel > 0 {
		// draw a circle for each combo
		for (var i = 0; i < comboHitsToNextLevel; i++) {
			draw_set_color(c_white);
			draw_circle(20+(i*20),y1,10,true);
			if comboEffectiveNumber > i {
				draw_circle_color(20+(i*20),y1,10,c_purple,c_white,false);
			}
		}
		
		var scale = 1;
		var angle = 0;
		if comboFrame <= 10 {
			scale = (5/(comboFrame+1));
		}
		if comboEffectiveNumber > 0 {
			draw_circle_color(20+((comboEffectiveNumber-1)*20),y1,scale*10,c_purple,c_white,false);
		}
		
		// how long until combo chain dies
		var percentDrained = ((1-comboFrame/comboTimeQuantum)*100);
		draw_healthbar(10,y1+15,10+(comboHitsToNextLevel*20),y1+20,percentDrained,c_black,c_purple,c_white,0,true,true);
	}
	// draw the bar for combo level 
	if comboModeLevel > 0 {
		
		draw_sprite_part(spr_combo_meter_empty,1,0,0,200,50,100,y1);
		var w = sprite_get_width(spr_combo_meter_full);
		w = w*(comboModeFrame/comboModeTotalFrames);
		draw_sprite_part(spr_combo_meter_full,1,0,0,w,25,100,y1);
		draw_set_halign(fa_center);
		var scale = 1;
		if comboModeFrame >= comboModeTotalFrames-10 {
			scale = (5/((comboModeTotalFrames-comboModeFrame)+1));
		}
		draw_set_font(font_damage);
		scr_draw_text_outline(150,y1,string(comboModeLevel*25+100)+"%",c_silver,c_white,scale,scale,0);
	}
}
draw_set_alpha(1);