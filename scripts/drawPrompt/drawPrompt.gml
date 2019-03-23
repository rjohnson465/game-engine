/// drawInputPrompt(promptMessage,inputKeyEnums,*x,*y,*messageColor, *maxW)

/// @param promptMessage
/// @param inputKeyEnums
/// @param *x
/// @param *y
/// @param *messageColor
/// @param *maxW

// returns the width of the prompt

var msg = argument[0];
var keys = argument[1];
if !is_array(keys) {
	keys = [keys];
}

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
var maxW = 300;
if argument_count == 6 {
	xx = argument[2];
	yy = argument[3];
	msgColor = argument[4];
	maxW = argument[5];
}

draw_set_font(font_main);
var promptWidth = string_width(msg);
var promptHeight = string_height(msg);

// do not allow prompts to be too long
var stringScale = 1;
if promptWidth > maxW {
	stringScale = maxW / promptWidth;
}
promptWidth *= stringScale;

var spritesMap = ds_map_create();
var isGamepadConnected = gamepad_is_connected(global.gamePadIndex);

var spritesWidth = 0;
// get sprites for inputKeyEnums
for (var i = 0; i < array_length_1d(keys); i++) {
	var key = keys[i];
	var sprite = noone;
	switch key {
		case Input.F: {
			sprite = isGamepadConnected ? spr_prompt_xbox_a : spr_prompt_mk_f;
			break;
		}
		case Input.Backspace: {
			sprite = isGamepadConnected ? spr_prompt_xbox_x : spr_prompt_mk_backspace;
			break;
		}
		case Input.Escape: {
			sprite = isGamepadConnected ? spr_prompt_xbox_b : spr_prompt_mk_escape;
			break;
		}
		case Input.Shift: {
			sprite = isGamepadConnected ? spr_prompt_xbox_back : spr_prompt_mk_shift;
			break;
		}
		case Input.LMB: {
			sprite = isGamepadConnected ? spr_prompt_xbox_lb : spr_prompt_mk_lb;
			break;
		}
		case Input.RMB: {
			sprite = isGamepadConnected ? spr_prompt_xbox_rb : spr_prompt_mk_rb;
			break;
		}
		case Input.Mouse: {
			sprite = spr_prompt_mk_mouse;
			break;
		}
		case Input.LT: {
			sprite = spr_prompt_xbox_lt;
			break;
		}
		case Input.RT: {
			sprite = spr_prompt_xbox_rt;
			break;
		}
		case Input.LB: {
			sprite = spr_prompt_xbox_lb;
			break;
		}
		case Input.RB: {
			sprite = spr_prompt_xbox_rb;
			break;
		}
		case Input.PadUD: {
			sprite = spr_prompt_xbox_pad_ud; 
			break;
		}
		case Input.PadLR: {
			sprite = spr_prompt_xbox_pad_lr;
			break;
		}
		case Input.MMB: {
			sprite = spr_prompt_mk_mb;
			break;
		}
		case Input.Face4: {
			sprite = spr_prompt_xbox_y;
			break;
		}
	}
	
	ds_map_replace(spritesMap,i,sprite);
	var sw = sprite_get_width(sprite)*.35;
	var sh = sprite_get_height(sprite)*.35;

	draw_set_halign(fa_left);
	draw_set_font(font_main);

	promptWidth += sw;

}

draw_set_alpha(.5);
draw_set_color(c_black);
if argument_count < 3 {
	draw_rectangle(xx-(.5*promptWidth)-5,yy-(.5*sh)-5,xx+(.5*promptWidth)+5,yy+(.5*sh)+5,0);
} else {
	draw_rectangle(xx-5,yy-5,xx+promptWidth+5,yy+sh+5,false);
}
draw_set_alpha(1);
draw_set_color(c_white);
if argument_count < 3 {
	draw_rectangle(xx-(.5*promptWidth)-5,yy-(.5*sh)-5,xx+(.5*promptWidth)+5,yy+(.5*sh)+5,1);
} else {
	draw_rectangle(xx-5,yy-5,xx+promptWidth+5,yy+sh+5,true);
}

for (var i = 0 ; i < array_length_1d(keys); i++) {
	var sprite = ds_map_find_value(spritesMap,i);
	var sw = sprite_get_width(sprite)*.35;
	var sh = sprite_get_height(sprite)*.35;
	// center bottom screen
	if argument_count < 3 {
		draw_sprite_ext(sprite,1,xx-(.5*promptWidth)+spritesWidth,yy-(.5*sh),.35,.35,0,c_white,1);
	} else {
		draw_sprite_ext(sprite,1,xx+spritesWidth,yy,.35,.35,0,c_white,1);
	}
	spritesWidth += (sw);
}


draw_set_valign(fa_center);
// center bottom screen
if argument_count < 3 {
	scr_draw_text_outline(xx-(.5*promptWidth)+spritesWidth,yy/*-(.5*sh)+(sh*.5)*/+2,msg,msgColor,msgColor,stringScale,1,0,c_black);
} else {
	scr_draw_text_outline(xx+spritesWidth,yy+(sh*.5)+2,msg,msgColor,msgColor,stringScale,1,0,c_black);
}

ds_map_destroy(spritesMap); spritesMap = -1; // memory leaks 
return promptWidth+10; // 10px padding

