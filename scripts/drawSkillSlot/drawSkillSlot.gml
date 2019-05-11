/// drawSkillSlot(x,y,slot,skill)
/// @param x
/// @param y
/// @param slot

var xx = argument0;
var yy = argument1;
var slot = argument2;
var skill = argument3;


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

with skill {
	// xxx and yyy are the bottom right coordinate of a skill
	var xxx = xx + sprite_get_width(spr_item_slot); var yyy = yy + sprite_get_width(spr_item_slot);
	var xx1 = xxx-17; var yy1 = yyy-17; var xx2 = xxx-2; var yy2 = yyy-2;
	if global.player.skillPoints > 0 && skill.level != skill.levelMax {
		if mouseOverGuiRect(xx1,yy1,xx2,yy2) && mouse_check_button_released(mb_left) {
			with obj_skill_selector {
				levelUpSkill();
			}
		}
		else if mouseOverGuiRect(xx1,yy1,xx2,yy2) && mouse_check_button(mb_left) {
			draw_set_color(make_color_rgb(25,2,2));
		}
		else if mouseOverGuiRect(xx1,yy1,xx2,yy2) {
			draw_set_color(c_red);
		}
		else draw_set_color(c_maroon);
	
	} else draw_set_color(c_ltgray);
	
	draw_rectangle(xx1,yy1,xx2,yy2,0);
	draw_set_color(c_black);
	draw_rectangle(xx1-1,yy1-1,xx2,yy2,1);

	draw_set_halign(fa_center); draw_set_valign(fa_top);
	scr_draw_text_outline(mean(xx1,xx2),yy1,"+",c_white,c_ltgray);
	
	
}

