var alphaMod = 1;
if global.fountainGui.currentSubMenu != NAMEPRICE {
	alphaMod = .2;
	draw_set_alpha(.2);
} else {
	draw_set_alpha(1);
}

if !gamepad_is_connected(global.player.gamePadIndex) {
	// draw back button
	draw_sprite_ext(spr_button_next,1,backButtonTopLeftX+30,backButtonTopLeftY,-1,1,0,c_white,draw_get_alpha());
}

draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_color(c_white);
draw_text(mean(topLeftX,topLeftX+width),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),"Name Price");

var coinsScale = 25/slotHeight;
// named price box
var x1 = topLeftX+2 var y1 = topLeftY+1+subMenuTitleHeight+subMenuTitleHeight;
var x2 = topLeftX+2+((width/2)-1); var y2 = topLeftY+1+subMenuTitleHeight+subMenuTitleHeight+25;
draw_text(mean(x1,x2),mean(topLeftY+subMenuTitleHeight,topLeftY+subMenuTitleHeight+subMenuTitleHeight),"Proposal");
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_sprite_ext(spr_item_coins,1,x1,y1,coinsScale,coinsScale,0,c_white,1);
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,1);
draw_set_halign(fa_right);
draw_text(x2,mean(y1,y2),string(namedPrice));

// current funds box
var x1 = x2+1; var x2 = x1+((width/2)-1)-1;
draw_text(mean(x1,x2),mean(topLeftY+subMenuTitleHeight,topLeftY+subMenuTitleHeight+subMenuTitleHeight),"Funds");
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_sprite_ext(spr_item_coins,1,x1,y1,coinsScale,coinsScale,0,c_white,1);
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,1);
draw_text(x2,mean(y1,y2),string(getGoldCount()));

var x1 = topLeftX; var x2 = topLeftX+width;
y2+=10;
draw_set_valign(fa_top); draw_set_halign(fa_center);
// options
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	var str = ds_list_find_value(allPriceIncrements,i);
	if selectedPriceIncrease == str {
		draw_set_alpha(1*alphaMod);
	} else {
		draw_set_alpha(.5*alphaMod);
	}
	draw_text(mean(x1,x2),y2+(25*i),str);
}

/*// click zones
var midW = mean(topLeftX,topLeftX+width); var midH = 200;
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	var opt = ds_list_find_value(allPriceIncrements,i);
	var w = string_width(opt); var h = string_height(opt);
	var yy = midH+((i)*25);
	var x1 = midW-(.5*w); var y1 = yy-(.5*h);
	var x2 = midW+w; var y2 = yy+h;
	draw_rectangle(x1,y1,x2,y2,1);
}*/

// likeliness of it working
odds = namedPrice >= guaranteedPrice ? 100 : 0;
draw_set_alpha(.5);
draw_text(mean(x1,x2),y2+((ds_list_size(allPriceIncrements)+1)*25)+slotHeight,"Odds of it working: " + string(odds) + "%" );
