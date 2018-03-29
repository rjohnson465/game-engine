// if player is locked on to this enemy, view hp / name in top middle screen
if owner == global.player.lockOnTarget {
	draw_set_font(font_main);
	var name = owner.name;
	var nameWidth = string_width(name);
	var nameHeight = string_height(name);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var middleX = view_get_wport(view_camera[0])/2;
	
	var projectedWidth = nameWidth+20;
	var widthBuffer = 10;
	if projectedWidth < 250 {
		var diff = 250 - projectedWidth;
		widthBuffer = diff / 2;
	}
	
	var x1 = middleX-(.5*nameWidth)-widthBuffer;
	var y1 = 11;
	var x2 = middleX+(.5*nameWidth)+widthBuffer;
	var y2 = 15+nameHeight;
	var percentHp = (owner.hp / owner.maxHp)*100;
	draw_healthbar(x1,y1,x2,y2,percentHp,c_black,c_red,c_maroon,0,1,1);
	draw_set_color(c_white);
	draw_text(middleX,15,name);
	draw_set_font(font_small);
	draw_text(middleX,y2+2,owner.description);
	draw_set_font(font_main);
}