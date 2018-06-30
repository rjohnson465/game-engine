var alphaMod = 1;
if global.fountainGui.currentSubMenu != NAMEPRICE {
	alphaMod = .2;
	draw_set_alpha(.2);
} else {
	draw_set_alpha(1);
}
draw_set_font(font_main);

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

//var x1 = topLeftX; var x2 = topLeftX+width;
var startY = y2+10;

// options
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	
	var str = ds_list_find_value(allPriceIncrements,i);
	var sh = string_height(str); var sw = string_width(str);
	draw_set_valign(fa_center); draw_set_halign(fa_center);
	
	var xx = mean(topLeftX,topLeftX+width); var yy = startY+(i*sh);
	var x1 = xx-(sw/2); var y1 = yy-(sh/2); 
	var x2 = xx+(sw/2); var y2 = yy+(sh/2);
	
	if global.fountainGui.currentSubMenu == NAMEPRICE && (mouseOverGuiRect(x1,y1,x2,y2) || selectedPriceIncrease == str) {
		draw_set_color(c_white);
		if selectedPriceIncrease != str {
			audio_play_sound(snd_ui_option_change,1,0);
		}
		selectedPriceIncrease = str;
	} else {
		draw_set_color(c_ltgray);
	}
	
	draw_text(xx,yy,str);
	
	// handle click event for price options
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) && global.fountainGui.currentSubMenu == NAMEPRICE {
		var newProposal = namedPrice;
		
		switch (str) {
			case WISH: {
				if global.fountainGui.currentMenu == INSERTGEM {
					attemptGemInsertion();
				} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
					attemptItemBreakDown();
				} else if global.fountainGui.currentMenu == REPAIRITEM {
					attemptRepairItem();
				}
				exit;
			}
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
			case INCREASE1M: {
				newProposal += 1000000; break;
			}
		}
		// ensure we have enough gold for new proposal
		if str != WISH {
			if newProposal < getGoldCount() {
				namedPrice = newProposal;
				audio_play_sound(snd_item_coins,1,0);
			} else {
				alert("You do not have enough gold", c_red);
			}
		}
	}

}

// likeliness of it working
odds = namedPrice >= guaranteedPrice ? 100 : 0;
//draw_set_alpha(.5);
draw_set_color(c_white);
draw_text(mean(x1,x2),mean(topLeftY,MENUS_BOTTOMRIGHT_Y),"Odds of it working: " + string(odds) + "%" );

// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if global.fountainGui.currentSubMenu == NAMEPRICE {
	// controller prompts
	if gamepad_is_connected(global.player.gamePadIndex) {
		w += drawPrompt("Select option", Input.F,promptsStartX+w,promptsY)+xOffset;
		if global.fountainGui.currentMenu == INSERTGEM {
			w += drawPrompt("Return to Choose Gem", Input.Escape, promptsStartX+w,promptsY);
		} else {
			w += drawPrompt("Return to Choose Item", Input.Escape, promptsStartX+w,promptsY);
		}
	}
	// m/k prompts
	else {
		w += drawPrompt("Select option", Input.LMB,promptsStartX+w,promptsY)+xOffset;
	}
}

draw_set_color(c_black); draw_set_alpha(1);
draw_rectangle(topLeftX,topLeftY+subMenuTitleHeight,topLeftX+width,MENUS_BOTTOMRIGHT_Y,1);