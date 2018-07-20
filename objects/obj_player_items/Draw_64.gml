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
	
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var s = "Yes";
	var sw = string_width(s); var sh = string_height(s);
	if (point_in_rectangle(mouse_x,mouse_y,vx+x1+5,vy+y1+100,vx+x1+5+sw,vy+y1+100+sh) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		(isYes && gamepad_is_connected(global.player.gamePadIndex))
	{
		draw_set_color(c_white);
	} else {
		draw_set_color(c_ltgray);
	}
	draw_text(x1+5,y1+100,s);
	
	// actually buy item if clicked
	if	(point_in_rectangle(mouse_x,mouse_y,vx+x1+5,vy+y1+100,vx+x1+5+sw,vy+y1+100+sh) && !gamepad_is_connected(global.player.gamePadIndex)) && 
		mouse_check_button_pressed(mb_left) 
	{
		sellItem(selectedItem);
	}
	
	draw_set_halign(fa_right);
	var s = "No";
	var sw = string_width(s); var sh = string_height(s);
	var xx1 = x2-5; var yy1 = y1+100;
	var xx2 = xx1-sw; var yy2 = yy1+sh;
	if (point_in_rectangle(mouse_x,mouse_y,vx+xx2,vy+yy1,vx+xx1,vy+yy2) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		(!isYes && gamepad_is_connected(global.player.gamePadIndex))
	{
		draw_set_color(c_white);
	} else {
		draw_set_color(c_ltgray);
	}
	draw_text(xx1,yy1,"No");
	
	// cancel confirm if "No" clicked
	if	(point_in_rectangle(mouse_x,mouse_y,vx+xx2,vy+yy1,vx+xx1,vy+yy2) && !gamepad_is_connected(global.player.gamePadIndex)) && 
		mouse_check_button_pressed(mb_left)
	{
		audio_play_sound(snd_ui_click1,1,0);
		isConfirming = false;
		isAcceptingConfirmInput = false;
	}
}

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