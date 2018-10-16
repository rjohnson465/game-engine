if !gamepad_is_connected(global.player.gamePadIndex) {
	//selectedPriceIncrease = noone;	
} else if selectedPriceIncrease == noone {
	selectedPriceIncrease = RESETPRICE;
}

var alphaMod = 1;
if global.fountainGui.currentSubMenu != NAMEPRICE {
	alphaMod = .2;
	draw_set_alpha(.2);
} else {
	draw_set_alpha(1);
}
draw_set_font(font_main);

draw_set_color(c_black);
draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, 1);
draw_line(topLeftX, topLeftY+subMenuTitleHeight, bottomRightX, topLeftY+subMenuTitleHeight);

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !gamepad_is_connected(global.player.gamePadIndex) {
	// draw back button
	if !isBackButtonPressed {
		draw_sprite_ext(spr_button_next,1,backButtonTopLeftX+30,backButtonTopLeftY,-1,1,0,c_white,draw_get_alpha());
	} else {
		draw_sprite_ext(spr_button_next,1,backButtonTopLeftX+30,backButtonTopLeftY,-1,1,0,c_gray,draw_get_alpha());
	}
}

if	mouseOverGuiRect(backButtonTopLeftX, backButtonTopLeftY, backButtonTopLeftX+sprite_get_width(spr_button_next), backButtonTopLeftY+sprite_get_height(spr_button_next)) &&
	mouse_check_button_released(mb_left) {
		goBackFromNamePrice();
	
}

draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_color(c_white);
draw_text(mean(topLeftX,topLeftX+width),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),"Name Price");

var coinsScale = 25/slotHeight;
// named price box
var x1 = topLeftX+5 var y1 = topLeftY+1+subMenuTitleHeight+subMenuTitleHeight;
var x2 = topLeftX+2+((width/2)-5); var y2 = topLeftY+1+subMenuTitleHeight+subMenuTitleHeight+25;
draw_set_halign(fa_center);
draw_text(mean(x1,x2),mean(topLeftY+subMenuTitleHeight,topLeftY+subMenuTitleHeight+subMenuTitleHeight),"Proposal");
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(c_gray);
draw_rectangle(x1,y1,x1+(sprite_get_width(spr_item_coins)*coinsScale)+5,y2,0);
draw_sprite_ext(spr_item_coins,1,x1+5,y1,coinsScale,coinsScale,0,c_white,1);
draw_set_color(c_white);
draw_rectangle(x1-1,y1,x2,y2,1);
draw_set_halign(fa_right);
draw_text(x2-5,mean(y1,y2),string(namedPrice));
var mppx = mean(x1,x2); // midpoint proposal, x
var px1 = x1; // proposal x1

// current funds box
var x1 = x2+5; var x2 = x1+((width/2)-1)-5;
draw_set_halign(fa_center);
draw_text(mean(x1,x2),mean(topLeftY+subMenuTitleHeight,topLeftY+subMenuTitleHeight+subMenuTitleHeight),"Funds");
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(c_gray);
draw_rectangle(x1,y1,x1+(sprite_get_width(spr_item_coins)*coinsScale)+5,y2,0);
draw_sprite_ext(spr_item_coins,1,x1+5,y1,coinsScale,coinsScale,0,c_white,1);
draw_set_color(c_white);
if namedPrice > getGoldCount() {
	draw_set_color(c_red);
}
draw_rectangle(x1,y1,x2,y2,1);
draw_set_halign(fa_right);
draw_text(x2-5,mean(y1,y2),string(getGoldCount()));
var mpfx = mean(x1,x2); // midpoint funds, x
var fx1 = x1; // funds x1
var pad = global.gamePadIndex;
// Make wish / reset buttons
var s = WISH; var sh = string_height(s); var sw = string_width(s);
var y1 = y2+10; var y2 = y1 + sh + 20;
var x1 = mppx-((sw/2)+10); var x2 = mppx + ((sw/2) + 10);
draw_set_color(c_green);
if ((mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left)) 
		|| (selectedPriceIncrease == WISH && (gamepad_is_connected(pad) && gamepad_button_check(pad,gp_face1)))) 
		&& global.fountainGui.currentSubMenu == NAMEPRICE {
	draw_set_color(c_black);
}
else if (mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && selectedPriceIncrease == WISH)) && global.fountainGui.currentSubMenu == NAMEPRICE {
	if selectedPriceIncrease != WISH {
		audio_play_sound(snd_ui_option_change,1,0);
	}
	selectedPriceIncrease = WISH;
	draw_set_color(c_olive);
}
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,1);
draw_set_halign(fa_center); 
draw_set_color(c_white);
draw_text(mean(x1,x2), mean(y1,y2),s);
// clicked
if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) && global.fountainGui.currentSubMenu == NAMEPRICE {
	if global.fountainGui.currentMenu == INSERTGEM {
		attemptGemInsertion();
	} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
		attemptItemBreakDown();
	} else if global.fountainGui.currentMenu == REPAIRITEM {
		attemptRepairItem();
	}
}

// reset button 
var s = RESETPRICE; var sh = string_height(s); var sw = string_width(s);
var x1 = mpfx-((sw/2)+10); var x2 = x1 + (sw + 10);
draw_set_color(c_maroon);
if ((mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left)) 
		|| (selectedPriceIncrease == RESETPRICE && (gamepad_is_connected(pad) && gamepad_button_check(pad,gp_face1)))) 
		&& global.fountainGui.currentSubMenu == NAMEPRICE {
	draw_set_color(c_black);
}
else if (mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && selectedPriceIncrease == RESETPRICE)) && global.fountainGui.currentSubMenu == NAMEPRICE {
	if selectedPriceIncrease != RESETPRICE {
		audio_play_sound(snd_ui_option_change,1,0);
	}
	selectedPriceIncrease = RESETPRICE;
	draw_set_color(c_red);
}
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,1);
draw_set_halign(fa_center); 
draw_set_color(c_white);
draw_text(mean(x1,x2), mean(y1,y2),s);
// clicked
if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) && global.fountainGui.currentSubMenu == NAMEPRICE {
	namedPrice = 0;
	audio_play_sound(snd_item_coins,1,0);
}

var y1 = y2 + 25;
var y2 = y1 + 25;
draw_text(mean(topLeftX, topLeftX + width), y1, "Add to wish");

if allPriceIncrements == undefined || !ds_exists(allPriceIncrements, ds_type_list) exit;
// price increments
var y1 = y2; 
var buttonPadding = 5; 
var x1 = topLeftX;
var buttonWidth = (width/ds_list_size(allPriceIncrements))-(buttonPadding);
var buttonHeight = string_height("s") + 10 ;
var y2 = y1+buttonHeight;
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	var s = ds_list_find_value(allPriceIncrements, i);
	x1 += 5;
	var x2 = x1 + buttonWidth;
	draw_set_color(c_dkgray);
	if ((mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left)) 
		|| (selectedPriceIncrease == s && (gamepad_is_connected(pad) && gamepad_button_check(pad,gp_face1)))) 
		&& global.fountainGui.currentSubMenu == NAMEPRICE {
		draw_set_color(c_black);
	}
	else if (mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && selectedPriceIncrease == s)) && global.fountainGui.currentSubMenu == NAMEPRICE {
		if selectedPriceIncrease != s {
			audio_play_sound(snd_ui_option_change,1,0);
		}
		selectedPriceIncrease = s;
		draw_set_color(c_ltgray);
	}
	draw_rectangle(x1,y1,x2,y2,0);
	draw_set_color(c_black);
	draw_rectangle(x1,y1,x2,y2,1);
	draw_set_halign(fa_center);
	
	var sw = string_width(s);
	var scale = 1;
	if sw / buttonWidth > 1 {
		scale = buttonWidth / sw;
	}
	draw_set_color(c_white);
	draw_text_transformed(mean(x1,x2), mean(y1, y2), s, scale, scale, 0);
	
	// clicked
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) && global.fountainGui.currentSubMenu == NAMEPRICE {
		var newProposal = namedPrice;
		switch s {
			case RESETPRICE: {
				newProposal = 0; break;
			}
			case INCREASE100: {
				newProposal += 100; break;
			}
			case INCREASE1K: {
				newProposal += 1000; break;
			}
			case INCREASE10K: {
				newProposal += 10000; break;
			}
			case INCREASE100K: {
				newProposal += 100000; break;
			}
		}
		if newProposal < getGoldCount() {
			namedPrice = newProposal;
			audio_play_sound(snd_item_coins,1,0);
		} else {
			alert("You do not have enough gold", c_red);
		}
	}
	
	x1 = x2;
}

// likeliness of it working
//odds = namedPrice >= guaranteedPrice ? 100 : 0;
odds = calculateWishOdds(namedPrice, guaranteedPrice);
//draw_set_alpha(.5);
draw_set_color(c_white);
draw_text(mean(topLeftX,topLeftX+width),mean(MENUS_BOTTOMRIGHT_Y-100,MENUS_BOTTOMRIGHT_Y),"Odds of it working: " + string(odds) + "%" );

// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if global.fountainGui.currentSubMenu == NAMEPRICE {
	// controller prompts
	if gamepad_is_connected(global.player.gamePadIndex) {
		w += drawPrompt("Return to previous menu", Input.Escape, promptsStartX+w,promptsY);
	}

}