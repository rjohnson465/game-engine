
draw_set_color(c_white);
draw_set_font(font_main);
draw_set_halign(fa_left);
var x1 = victim.x+(victim.sprite_width*.5)+5;
var y1 = victim.y-(victim.sprite_height*.5)-20;
var text = round(amount);
if frame > 15 {
	draw_set_alpha(1-(frame/15));
}
script_execute(scr_draw_text_outline,x1,y1,text,c_black);
draw_set_alpha(1);
//draw_text(victim.x+(victim.sprite_width*.5)+5,victim.y-(victim.sprite_height*.5)-20,round(amount));