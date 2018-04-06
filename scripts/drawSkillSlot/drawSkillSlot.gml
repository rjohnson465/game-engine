/// drawSkillSlot(x,y,slot,skill)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;
var skill = argument3;
var ui = global.ui; 

var drawDark = false;
with obj_skill_selector {
	if x1 == xx && y1 == yy {
		drawDark = true;
	} 
}
if drawDark {
	draw_sprite_ext(spr_item_slot,1,xx,yy,1,1,0,c_gray,.75);
} else {
	draw_sprite(spr_item_slot,1,xx,yy);
}

var sprite = skill.skillSprite;

if global.player.skillPoints > 0 {
	draw_sprite(sprite,1,xx,yy);
} else {
	shader_set(shd_greyscale);
    shader_set_uniform_f(shader_get_uniform(shd_greyscale,"fade"), 1);
	draw_sprite(sprite,1,xx,yy);
	shader_reset();
}

draw_set_valign(fa_top); draw_set_halign(fa_left);
scr_draw_text_outline(skill.x1,skill.y1,skill.level,c_white,c_white);

