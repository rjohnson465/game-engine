drawPlayerItems();

if isConfirming {
	var x1 = topLeftX-width+5; var y1 = topLeftY+100;
	var x2 = x1+width-10; var y2 = y1+150;
	draw_set_color(c_gray); draw_set_alpha(.5); 
	draw_rectangle(x1,y1,x2,y2,0);
	
	draw_set_alpha(1);
	// handle
	draw_set_color(C_HANDLES);
	draw_rectangle(x1,y1,x2,y1+menusHandleHeight,0);
	draw_set_color(c_white); draw_set_font(font_main);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(x1,x2),mean(y1,y1+menusHandleHeight),"Confirm Sale");
	
	draw_set_color(c_white); draw_set_halign(fa_center); 
	draw_text_ext(mean(x1,x2),y1+50,"Sell " + selectedItem.name + " for " + string(selectedItem.value) + " gold?",-1,x2-x1);
	
	// Yes button
	var s = "Yes";
	var sw = string_width(s); var sh = string_height(s);
	var textColor = noone;
	var buttonColor = noone;
	
	var x1 = x1+50; var y1 = y1+100-5;
	var x2 = x1+5+sw+10; var y2 = y1+sh+5;
	if (mouseOverGuiRect(x1, y1, x2, y2) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		(isYes && gamepad_is_connected(global.player.gamePadIndex))
	{
		textColor = c_white;
		buttonColor = c_green;
	} else {
		textColor = c_ltgray;
		buttonColor = c_gray;
		if confirmOption != "N" {
			confirmOption = noone;
		}
	}
	
	draw_set_color(buttonColor);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, true);
	
	draw_set_color(textColor);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(x1, x2),mean(y1, y2),s);
	
	// actually buy item if clicked
	if	(mouseOverGuiRect(x1, y1, x2, y2) && !gamepad_is_connected(global.player.gamePadIndex)) {
		if confirmOption != "Y" audio_play_sound(snd_ui_option_change,1,0);
		confirmOption = "Y";
		if mouse_check_button_pressed(mb_left)  {
			sellItem(selectedItem);
		}
	}
	
	// No button
	var s = "No";
	var sw = string_width(s); var sh = string_height(s);
	x1 = x2 + 150; 
	x2 = x1 + sw + 10; 
	if (mouseOverGuiRect(x1, y1, x2, y2) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		(!isYes && gamepad_is_connected(global.player.gamePadIndex))
	{
		textColor = c_white;
		buttonColor = c_red;
	} else {
		textColor = c_ltgray;
		buttonColor = c_gray;
		if confirmOption != "Y" {
			confirmOption = noone;
		}
	}
	draw_set_color(buttonColor);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, true);

	draw_set_color(textColor);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(x1, x2),mean(y1, y2),s);
	
	// cancel confirm if "No" clicked
	if	(mouseOverGuiRect(x1, y1, x2, y2) && !gamepad_is_connected(global.player.gamePadIndex)) {
		if confirmOption != "N" audio_play_sound(snd_ui_option_change,1,0);
		confirmOption = "N";
		if mouse_check_button_pressed(mb_left) {
			audio_play_sound(snd_ui_click1, 1, 0);
			isConfirming = false;
			isAcceptingConfirmInput = false;
		}
	}
}

/*
// draw player funds
draw_set_color(c_black);
draw_set_font(font_main);
var x1 = itemDescriptionTopLeftX; var y1 = itemDescriptionBottomRightY;
var sh = string_height("s");
var x2 = itemDescriptionBottomRightX; var y2 = y1+sh+5;

draw_rectangle(x1,y1,x2,y2,0);

var w = sprite_get_width(spr_item_info_defense_crush);
var xs = w/sprite_get_width(spr_item_coins);
draw_sprite_ext(spr_item_coins,1,x1+5,y1,xs,xs,0,c_white,1);

draw_set_color(c_white);
draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(x1,x2), mean(y1,y2),"Your funds: " + string(getGoldCount()));