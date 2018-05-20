
if isActive {
	var step = ds_list_find_value(steps,currentStep);
	 draw_set_halign(fa_center); draw_set_font(font_main);
	var xx = view_get_wport(view_camera[0]) / 2;
	var yy = view_get_hport(view_camera[0]) - 100;
	
	var sh = string_height_ext(step.text,-1,view_get_wport(view_camera[0])/2);
	var sw = string_width_ext(step.text,-1,view_get_wport(view_camera[0])/2);
	draw_set_color(c_black);
	draw_rectangle(xx-(.5*sw)-5,yy-(.5*sh)-5,xx+(.5*sw)+5,yy+(.5*sh)+5,0);
	
	draw_set_color(c_white);
	draw_rectangle(xx-(.5*sw)-5,yy-(.5*sh)-5,xx+(.5*sw)+5,yy+(.5*sh)+5,1);
	
	
	draw_text_ext(xx,yy,step.text,-1,view_get_wport(view_camera[0])/2);
	
	//scr_draw_text_outline(xx,yy,step.text,c_white,c_white,1,1,0,c_black);
	
	drawPrompt("Skip", Input.F);
}