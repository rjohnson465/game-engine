/// drawInputPrompt(promptMessage,inputKeyEnums,*x,*y,*messageColor, *maxW, *drawAtInstanceCoordinates)

/// @param promptMessage
/// @param inputKeyEnums
/// @param *x
/// @param *y
/// @param *messageColor
/// @param *maxW
/// @param *drawAtInstanceCoordinates

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

// for each boss in the room, draw the prompt a bit higher
// to accomodate boss health bar
// (of course, this is only if this a lower screen prompt)
var bossCount = 0;
var atLeastOneBossAlive = false;
with obj_enemy_parent {
	if isBoss {
		if hp > 0 {
			atLeastOneBossAlive = true;
		}
		bossCount++;
	}
}
		
if atLeastOneBossAlive {
	yy -= bossCount*50;
}

// maybe assign explicit x value
if argument_count >= 3 && argument[2] != noone {
	xx = argument[2];
}
// maybe assign explicit y value
if argument_count >= 4 && argument[3] != noone {
	yy = argument[3];
}
// maybe assign explicit color value
var msgColor = c_white;
if argument_count >= 5 && argument[4] != noone {
	msgColor = argument[4];
}
// maybe assign explicit max width value
var maxW = 300;
if argument_count >= 6 && argument[5] != noone {
	maxW = argument[5];
}
// maybe draw this prompt at the invoking instance coordinates
var isDrawingAtInstanceCoordinates = false;
if argument_count >= 7 && argument[6] == true {
	isDrawingAtInstanceCoordinates = true;
	// draw prompts near invoking instance? 
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var xx = x - vx;
	var yy = y - vy;
}

draw_set_font(font_main);
var promptWidth = string_width(msg);

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
		case Input.Control: {
			sprite = spr_prompt_mk_ctrl;
			break;
		}
		case Input.DestroyInput: {
			sprite = isGamepadConnected ? spr_prompt_xbox_rs_click : spr_prompt_mk_mb;
			break;
		}
		case Input.Enter: {
			sprite = spr_prompt_mk_enter;
			break;
		}
		default: {
			sprite = noone;
			break;
		}
	}
	
	ds_map_replace(spritesMap,i,sprite);
	var sw = sprite_get_width(sprite)*.35;
	var sh = sprite_get_height(sprite)*.35;
	
	if sprite == noone {
		sw = 35; sh = 35;
	}

	draw_set_halign(fa_left);
	draw_set_font(font_main);

	promptWidth += sw;

}

// if this prompt would overflow the left edge of the room, move it to the right so it displays ok
if isDrawingAtInstanceCoordinates && x - (.5 * promptWidth) - 5 < 0 {
	xx = 5 - vx;
}

// if this prompt would overflow the right edge of the room, move it to the left so it displays ok
if isDrawingAtInstanceCoordinates && x + (promptWidth) + 5 > room_width {
	xx = room_width - ((.5 * promptWidth) + 2);
	xx = xx - vx;
	xx = room_width - promptWidth - 10 - vx;
}

var promptHeight = sh + 10;

// if this prompt would overflow the top edge of the room, move it down so it displays ok
if isDrawingAtInstanceCoordinates && y - (.5 * promptHeight) <= 0 {
	yy = 10 - vy;
}

// if this prompt would overflow the bottom edge of the room, move it up so it displays ok
if isDrawingAtInstanceCoordinates && y + (.5 * promptHeight) > room_height {
	yy = room_height - promptHeight - 20 - vy;
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
	if sprite > 0 {
		if argument_count < 3 {
			draw_sprite_ext(sprite,1,xx-(.5*promptWidth)+spritesWidth,yy-(.5*sh),.35,.35,0,c_white,1);
		} else {
			draw_sprite_ext(sprite,1,xx+spritesWidth,yy,.35,.35,0,c_white,1);
		}
	} else {
		sw = 35;
		sh = 35;
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

// if invoking instance is an interactable object and there are many interactables possible, draw toggle prompt
var p = global.player;
if	
	instance_exists(p) &&
	variable_instance_exists(p, "interactableObjects") &&
	ds_exists(p.interactableObjects, ds_type_list) &&
	!global.isLooting &&
	!global.isWishing &&
	!global.isInteractingWithNpc &&
	!global.isTrading &&
	!global.isReadingTutorial &&
	ds_list_find_index(p.interactableObjects, id) != -1 {
	if ds_list_size(p.interactableObjects) > 1 {
		
		var tSprite = isGamepadConnected ? spr_prompt_xbox_y : spr_prompt_mk_r;
		var tSpriteWidth = sprite_get_width(tSprite);
		var tSpriteWidthAdjusted = tSpriteWidth * .35 * .95;
		var tString = "Toggle";
		var tStringWidth = string_width(tString);
		var tStringWidthAdjusted = tStringWidth * .95;
		promptWidth = tStringWidthAdjusted + tSpriteWidthAdjusted;
		

		if !isDrawingAtInstanceCoordinates {
			xx = view_get_wport(view_camera[0]) / 2;
		} 
		
		
		yy -= (sh*.5) + 15;
		sh = sh * .35;
		yy -= .5*sh;
		
		// rectangle
		draw_set_alpha(.5);
		draw_set_color(c_black);
		draw_rectangle(xx-(.5*promptWidth)-2,yy-(.5*sh)-7,xx+(.5*promptWidth)+2,yy+(.5*sh)+7,0);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_rectangle(xx-(.5*promptWidth)-2,yy-(.5*sh)-7,xx+(.5*promptWidth)+2,yy+(.5*sh)+7,1);
		
		
		
		// toggle sprite
		var sprScale = .35*.75;
		draw_sprite_ext(tSprite,1,xx-(.5*promptWidth)-0,yy-sh,sprScale,sprScale,0,c_white,1);
		
		
		// toggle text
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		scr_draw_text_outline(xx+10, yy, tString, c_white, c_white, .95, .95, 0, c_black);
		
	}
}

ds_map_destroy(spritesMap); spritesMap = -1; // memory leaks 
return promptWidth+10; // 10px padding

