/// drawInputPrompt(promptMessage,inputKeyEnum,*x,*y,*messageColor)

/// @param promptMessage
/// @param inputKeyEnum
/// @param *x
/// @param *y
/// @param *messageColor

// returns the width of the prompt

var msg = argument[0];
var key = argument[1];

var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var xx = vw/2;
var yy = vh - 50;

if argument_count == 3 {
	xx = argument[2];
}
if argument_count == 4 {
	xx = argument[2];
	yy = argument[3];
}
var msgColor = c_white;
if argument_count == 5 {
	xx = argument[2];
	yy = argument[3];
	msgColor = argument[4];
}

var sprite = noone;
var isGamepadConnected = gamepad_is_connected(global.player.gamePadIndex);
// get sprite for inputKeyEnum
switch key {
	case Input.F: {
		sprite = isGamepadConnected ? 
			asset_get_index("spr_prompt_xbox_a") :
			asset_get_index("spr_prompt_mk_f");
			break;
	}
	case Input.Backspace: {
		sprite = isGamepadConnected ? 
			asset_get_index("spr_prompt_xbox_x") :
			asset_get_index("spr_prompt_mk_backspace");
			break;
	}
	case Input.Escape: {
		sprite = isGamepadConnected ? 
			asset_get_index("spr_prompt_xbox_b") :
			asset_get_index("spr_prompt_mk_escape");
			break;
	}
	case Input.Shift: {
		sprite = isGamepadConnected ? spr_prompt_xbox_y : spr_prompt_mk_shift;
		break;
	}
}

var sw = sprite_get_width(sprite)*.35;
var sh = sprite_get_height(sprite)*.35;

draw_set_halign(fa_left);
draw_set_font(font_main);

var promptWidth = string_width(msg)+sw;
draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(xx-5,yy-5,xx+promptWidth+5,yy+sh+5,false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(xx-5,yy-5,xx+promptWidth+5,yy+sh+5,true);
draw_sprite_ext(sprite,1,xx,yy,.35,.35,0,c_white,1);
draw_set_valign(fa_center);
scr_draw_text_outline(xx+sw,yy+(sh*.5)+2,msg,msgColor,msgColor);

return promptWidth+10; // 10px padding