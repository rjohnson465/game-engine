
if isActive && currentStep != noone {
	var step = ds_list_find_value(steps,currentStep);
	draw_set_halign(fa_center); draw_set_font(font_main); 
	
	// draw_set_valign(fa_center);
	draw_set_valign(fa_top);
	
	var xx = view_get_wport(view_camera[0]) / 2;
	
	// this is the height at which the "Skip" prompt is drawn
	var yy = view_get_hport(view_camera[0]) - 50 - string_height("s") - 5;
	
	// yy -= 15; // 15px padding...
	
	var sh = string_height_ext(step.text,-1,view_get_wport(view_camera[0])/2);
	var sw = string_width_ext(step.text,-1,view_get_wport(view_camera[0])/2);
	
	// from prompt height (+ padding), reasses how high the conversation step text must be
	yy -= sh;
	var rectPadding = 5;
	yy -= (rectPadding*2); 
	
	// draw the current speaker and their name
	
	if step.speaker {
		
		// get the actual instance, since speaker is just an object index 
		var speakerObj = instance_nearest(x, y, step.speaker);
		
		if speakerObj {
			var speakerSprite = 
				variable_instance_exists(speakerObj, "faceSprite") ? speakerObj.faceSprite : -1;
		
			var faceX = xx - (.5*sw) - rectPadding - 15 - sprite_get_width(spr_item_slot);	
			var faceY = yy - rectPadding;
			var nameX = faceX; var nameY = faceY - string_height("s") - 5;
			draw_sprite_ext(spr_item_slot, 1, faceX, faceY, 1, 1, 0, c_black, .5);
			if speakerSprite {
				draw_sprite(speakerSprite, 1, faceX, faceY);
			}
			draw_set_color(c_white);
			draw_rectangle(faceX, faceY, faceX + 64, faceY + 64, 1);
		
			var speakerName = variable_instance_exists(speakerObj, "name") ? speakerObj.name : "";
			scr_draw_text_outline(mean(nameX, nameX + 64), nameY, speakerName, c_white, c_white, 1, 1, 0, c_black);
		}
		
	} 
	
	// draw conversation black box background / outline
	draw_set_color(c_black); draw_set_alpha(.5);
	draw_rectangle(xx-(.5*sw)-rectPadding,yy-rectPadding,xx+(.5*sw)+rectPadding,yy+sh+rectPadding,0);
	draw_set_color(c_white); draw_set_alpha(1);
	draw_rectangle(xx-(.5*sw)-rectPadding,yy-rectPadding,xx+(.5*sw)+rectPadding,yy+sh+rectPadding,1);
	
	// draw the actual conversation text
	draw_text_ext(xx,yy,step.text,-1,view_get_wport(view_camera[0])/2);
	
	// draw the skip prompt
	if canBeSkipped {
		drawPrompt("Skip", Input.F);
	}
}