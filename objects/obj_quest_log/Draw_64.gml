var p = global.player;
var pad = p.gamePadIndex;

var alphaMod = 1;
if !isActive && gamepad_is_connected(p.gamePadIndex) {
	alphaMod = .5;
}

draw_set_font(font_main);

if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,1);

// active quests header
draw_set_alpha(1); draw_set_color(C_HANDLES);
draw_rectangle(aqTopLeftX+1,aqTopLeftY,aqBottomRightX-1,aqTopLeftY+handlesHeight,0);
// active quests pane
draw_set_color(c_dkgray); draw_set_alpha(.75 * alphaMod);
draw_rectangle(aqTopLeftX+1, aqTopLeftY+handlesHeight+1, aqBottomRightX-1, aqBottomRightY-1, 0);

// border aq header
draw_set_color(c_black); draw_set_alpha(1 * alphaMod);
draw_rectangle(aqTopLeftX,aqTopLeftY,aqBottomRightX,aqTopLeftY+handlesHeight,1);
// aq header text
draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(aqTopLeftX,aqBottomRightX),mean(aqTopLeftY,aqTopLeftY+handlesHeight),"Quests");

// draw active quest names
var s = "test"; var sh = string_height(s);
var maxY = MENUS_BOTTOMRIGHT_Y-sh-10; var cumY = aqTopLeftY+sh+5;

// draw all active quests in left pane
var lastQuestIndexShown = scrollLevel-1; var drawnQuestsCount = 0;

if ds_list_size(p.quests) == 0 {
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(aqTopLeftX,aqBottomRightX),mean(aqTopLeftY,aqBottomRightY),"No quests to show");
}

ds_list_clear(displayedQuests);
for (var i = scrollLevel; i < ds_list_size(p.quests); i++) {
	var quest = ds_list_find_value(p.quests,i); // TODO account for scroll / offset
	
	// do not show quest if it is completed and we are not showing completed quests
	if quest.isFinished && quest.isRewardClaimed && !isShowingCompletedQuests {
		continue;
	}
	
	ds_list_add(displayedQuests, quest);
	draw_set_halign(fa_center); draw_set_valign(fa_bottom);
	var maxW = aqBottomRightX-aqTopLeftX-2-scrollBarWidth;
	
	var s = quest.name; var sh = string_height_ext(s,-1,maxW); var sw = string_width_ext(s,-1,maxW);
	
	cumY += sh+5;
	if cumY > maxY break;
	
	lastQuestIndexShown++; drawnQuestsCount++;
	// get quest text coordinates
	var xx = mean(aqTopLeftX,aqBottomRightX-scrollBarWidth); var yy = cumY;
	var x1 = xx-(.5*sw); var y1 = yy-(sh);
	var x2 = xx+(.5*sw); var y2 = yy;
	
	// if this is the selected quest, draw a highlight
	if quest == selectedQuest {
		var adjustedSh = string_height_ext(s,-1,maxW);
		draw_set_alpha(global.gameManager.selectedItemFilterAlpha * alphaMod); draw_set_color(C_HIGHLIGHT);
		var hx1 = xx-(.5*maxW); var hy1 = yy - (1 * adjustedSh);
		var hx2 = hx1 + maxW; var hy2 = hy1 + adjustedSh;
		draw_rectangle(hx1, hy1, hx2, hy2, 0);
	}
	
	// update text color based on mouse hover
	if mouseOverGuiRect(aqTopLeftX,y1,aqBottomRightX,y2) || selectedQuest == quest {
		draw_set_color(c_white);
		draw_set_alpha(1 * alphaMod);
		if quest.isFinished {
			draw_set_color(c_lime);
		}
	} else {
		draw_set_color(c_ltgray); draw_set_alpha(1 * alphaMod);
		if quest.isFinished {
			draw_set_color(c_lime);
			draw_set_alpha(.75 * alphaMod);
		}
	}
	
	// actually draw the quest name
	draw_text_ext(xx,yy,s,-1,maxW);
	draw_set_alpha(1 * alphaMod);
	
	// if click on quest name, make that the selected quest
	if mouseOverGuiRect(aqTopLeftX, y1, aqBottomRightX, y2) && mouse_check_button_pressed(mb_left) {
		selectedQuest = quest;
		audio_play_sound(snd_ui_option_change, 1, 0);
	}
}

lastQuestIndexDisplayed = lastQuestIndexShown;
questsDisplayedCount = drawnQuestsCount;

/// SCROLL BAR

// active quests scroll up event listener
var x1 = aqTopLeftX; var y1 = aqTopLeftY+string_height("s");
var x2 = aqBottomRightX; var y2 = aqBottomRightY;
if mouseOverGuiRect(x1,y1,x2,y2) && mouse_wheel_up() {
	if scrollLevel != 0 scrollLevel--;
}

// active quests scroll down event listener
if mouseOverGuiRect(x1,y1,x2,y2) && mouse_wheel_down() {
	if lastQuestIndexShown != ds_list_size(p.quests)-1 scrollLevel++;
}

// draw active quests scrollbar
draw_set_color(c_black);
draw_rectangle(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarBottomRightX,scrollBarBottomRightY,0);
var xs = scrollBarWidth/sprite_get_width(spr_scrollarrow);

// draw box showing how far down the quests we are
// need to know what the "maximal" scroll level is (at what scrollLevel is the last quest drawn?)
var msl = questLogGetMaxScrollLevel();
var percentScrolled = 0;
if msl > 0 {
	percentScrolled = scrollLevel / msl;
}

var scrollBarBoxStartY = scrollBarTopLeftY+scrollBarWidth;
var scrollBarBoxEndY = scrollBarBottomRightY-(2*scrollBarWidth);
var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

// how tall should the box be?
var scrollBarBoxHeight = scrollBarHeight;
if msl > 0 {
	scrollBarBoxHeight = scrollBarHeight/msl;
}

// recalc how much sbheight is
var scrollBarBoxEndY = scrollBarBottomRightY-scrollBarWidth-scrollBarBoxHeight;
var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

var yOff = scrollBarHeight*percentScrolled;
var x1 = scrollBarTopLeftX; var y1 = scrollBarBoxStartY+yOff;
draw_set_color(c_gray);
draw_rectangle(x1,y1,x1+scrollBarWidth,y1+scrollBarBoxHeight,0);



// draw scroll up arrow
// click on scroll up arrow?
if mouseOverGuiRect(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarTopLeftX+scrollBarWidth,scrollBarTopLeftY+scrollBarWidth) && mouse_check_button_pressed(mb_left) {
	if scrollLevel != 0 scrollLevel--;
	draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarTopLeftY+scrollBarWidth,xs,-xs,0,c_dkgray,1);
}
// mouse hover
else if	mouseOverGuiRect(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarTopLeftX+scrollBarWidth,scrollBarTopLeftY+scrollBarWidth) ||
	scrollLevel == 0
	{
		draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarTopLeftY+scrollBarWidth,xs,-xs,0,c_gray,1);
	}
// draw scroll up btn normally
else {
	draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarTopLeftY+scrollBarWidth,xs,-xs,0,c_white,1);
} 

// down arrow
// clicked
if mouseOverGuiRect(scrollBarTopLeftX,scrollBarBottomRightY-scrollBarWidth,scrollBarTopLeftX+scrollBarWidth,scrollBarBottomRightY) && mouse_check_button_pressed(mb_left) {
	if lastQuestIndexShown != ds_list_size(p.quests)-1 scrollLevel++;
	draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarBottomRightY-scrollBarWidth,xs,xs,0,c_dkgray,1);
}
// down arrow, hover
else if	mouseOverGuiRect(scrollBarTopLeftX,scrollBarBottomRightY-scrollBarWidth,scrollBarTopLeftX+scrollBarWidth,scrollBarBottomRightY) || lastQuestIndexShown == ds_list_size(p.quests)-1
	{
		draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarBottomRightY-scrollBarWidth,xs,xs,0,c_gray,1);
	} 
else {
	draw_sprite_ext(spr_scrollarrow,1,scrollBarTopLeftX,scrollBarBottomRightY-scrollBarWidth,xs,xs,0,c_white,1);
}

// divider line
draw_set_color(c_black);
draw_line(aqBottomRightX,aqTopLeftY,aqBottomRightX,aqBottomRightY);

// do not show selected quest if we are not showing completed quests and the selected quest is complete
if selectedQuest != noone && !isShowingCompletedQuests && selectedQuest.isFinished && selectedQuest.isRewardClaimed {
	if ds_list_size(displayedQuests) > 0 {
		selectedQuest = ds_list_find_value(displayedQuests, 0);
	} else {
		selectedQuest = noone;
	}
} else if selectedQuest == noone && isShowingCompletedQuests && ds_list_size(displayedQuests) > 0 {
	selectedQuest = ds_list_find_value(displayedQuests, 0);
}

// draw selected quest header box
draw_set_color(C_HANDLES); draw_set_alpha(1 * alphaMod);
draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,0);

// draw selected quest pane in dark gray
draw_set_color(c_dkgray); draw_set_alpha(.75 * alphaMod);
draw_rectangle(sqTopLeftX, sqTopLeftY+handlesHeight, sqBottomRightX, sqBottomRightY, 0);

// draw selected quest info
draw_set_alpha(1 * alphaMod);
if selectedQuest != noone && ds_exists(selectedQuest.questSteps,ds_type_list) {
	// selected quest header (quest selected);
	draw_set_color(c_black);
	draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,1);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqTopLeftY+handlesHeight),selectedQuest.name);
	
	// draw quest description
	var maxW = sqBottomRightX-sqTopLeftX-15;
	var sh = string_height_ext(selectedQuest.description,-1,maxW); var sw = string_width_ext(selectedQuest.description,-1,maxW);
	draw_set_halign(fa_left); draw_set_valign(fa_top); var yy = sqTopLeftY+handlesHeight+15;
	draw_text_ext(sqTopLeftX+8,yy,selectedQuest.description,-1,maxW)
	
	// draw each quest step
	var cumY = yy+sh;
	for (var i = 0; i < ds_list_size(selectedQuest.questSteps); i++) {
		var step = ds_list_find_value(selectedQuest.questSteps,i);
		//var sh = string_height("test");
		var s = step.description; 
		var sh = string_height_ext(s,-1,maxW);
		if step.status != QuestStepStatus.Unstarted {
			cumY += sh+10;
			
			if !step.isRewardStep {
				// get quest step color
				if step.status == QuestStepStatus.InProgress {
					draw_set_color(c_yellow);
				} else if step.status == QuestStepStatus.Completed {
					draw_set_color(c_lime);
				}
			
				// draw quest step
				draw_set_halign(fa_center); draw_set_valign(fa_center);
				draw_text_ext(mean(sqTopLeftX,sqBottomRightX),cumY,step.description,-1,maxW);
			} 
			// the reward step is drawn differently and responds to input
			else if !selectedQuest.isFinished {
				
				draw_set_halign(fa_center); draw_set_valign(fa_center);
				var s = step.description; var sh = string_height_ext(s,-1,maxW); var sw = string_width_ext(s,-1,maxW);
				
				// draw reward step as a button
				var xx = mean(sqTopLeftX,sqBottomRightX); var yy = cumY;
				var x1 = xx-(.5*sw)-5; var y1 = yy-(.5*sh)-5;
				var x2 = xx+(.5*sw)+5; var y2 = yy+(.5*sh)+5;
				
				var buttonColor = c_gray;
				var textColor = c_ltgray;
				
				// update text/button color based on mouse hover
				if mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && !gamepad_button_check(pad,gp_face1)) {
					buttonColor = c_green; textColor = c_white;
				} 
				
				// update text/button color based on mouse click
				if (mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left)) || (gamepad_is_connected(pad) && isActive && gamepad_button_check(pad,gp_face1)) {
					buttonColor = c_black; textColor = c_white;
				} 
				
				// button
				draw_set_color(buttonColor);
				draw_rectangle(x1,y1,x2,y2,0);
				// button outline
				draw_set_color(c_black);
				draw_rectangle(x1, y1, x2, y2, 1);
				// button text
				draw_set_color(textColor);
				draw_text_ext(xx,yy,s,-1,maxW);
				
				// gain quest reward if clicked on 
				if (point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) && mouse_check_button_released(mb_left)
				{
					completeQuest(selectedQuest);
				}
				
			}
			// selected quest is complete
			else {
				draw_set_halign(fa_center); draw_set_valign(fa_center);
				var s = "Quest complete!"; var sh = string_height_ext(s,-1,maxW); var sw = string_width_ext(s,-1,maxW);
				
				// draw reward step as a button
				var xx = mean(sqTopLeftX,sqBottomRightX); var yy = cumY;
				var x1 = xx-(.5*sw)-2; var y1 = yy-(.5*sh)-2;
				var x2 = xx+(.5*sw)+2; var y2 = yy+(.5*sh)+2;
				
				draw_set_color(c_lime);
				draw_text_ext(xx,yy,s,-1,maxW);
			}
		}
		// maybe add more space to the next step if this step contained a newline character
		var spos = string_pos("\n", s);
		if spos != 0 {
			cumY += string_height("s");
		}
	}
	
	// if quest is repeated, say so at the bottom
	if selectedQuest.isRepeatable {
		draw_set_halign(fa_center); draw_set_valign(fa_center);
		if !selectedQuest.isFinished || gamepad_is_connected(pad) {
			draw_set_color(c_white);
			draw_text(mean(sqTopLeftX,sqBottomRightX),sqBottomRightY-25,"This quest can be repeated once done");
		}
		else if selectedQuest.isFinished && !gamepad_is_connected(pad) {
			var sh = string_height("Repeat Quest"); var sw = string_width("Repeat Quest");
			var xx = mean(sqTopLeftX,sqBottomRightX); var yy = sqBottomRightY-25;
			var x1 = xx-(sw/2)-5; var y1 = yy-(sh/2)-5;
			var x2 = xx+(sw/2)+5; var y2 = yy+(sh/2)+5;
			
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left) {
				draw_set_color(c_black);
			} else if mouseOverGuiRect(x1,y1,x2,y2) {
				draw_set_color(c_green);
			} else {
				draw_set_color(c_gray);
			}
			
			draw_rectangle(x1,y1,x2,y2,0);
			draw_set_color(c_white);
			draw_text(xx,yy,"Repeat Quest");
			// border button
			draw_set_color(c_black);
			draw_rectangle(x1,y1,x2,y2,1);
			
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) {
				repeatQuest(selectedQuest);
			}
		}
	}
	
} else {
	// selected quest header (no quest selected);
	draw_set_color(c_black);
	draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,1);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqTopLeftY+handlesHeight),"Quest details");
	
	// no quest selected
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqBottomRightY),"No quest selected");
}

// show completed quests button
if !gamepad_is_connected(p.gamePadIndex) {
	var spr = spr_quest_show_completed; 
	var wsh = sprite_get_height(spr); var wsw = sprite_get_width(spr);
	var xx = aqBottomRightX-wsw-5; var yy = aqTopLeftY+3
	var x1 = xx; var y1 = yy; var x2 = xx+wsw; var y2 = yy+wsh;
	
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) {
		audio_play_sound(snd_ui_option_change,1,0);
		draw_sprite_ext(spr,1,xx,yy,1,1,0,c_black,1);
		isShowingCompletedQuests = !isShowingCompletedQuests;
	}
	else if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left) {
		draw_sprite_ext(spr,1,xx,yy,1,1,0,c_dkgray,1);
	}
	else if mouseOverGuiRect(x1,y1,x2,y2) {
		draw_sprite_ext(spr,1,xx,yy,1,1,0,c_dkgray,.75);
		
		// draw a little explanation for the button
		var str = isShowingCompletedQuests ? "Hide Completed Quests" : "Show Completed Quests";
		draw_set_font(font_main);
		var strW = string_width(str);
		var strH = string_height(str);
		draw_set_color(c_black); draw_set_alpha(.5 * alphaMod);
		var bx1 = mouse_x - vx;  var by1 = mouse_y - vy - 15;
		draw_rectangle(bx1, by1, bx1 + strW, by1 + strH, 0);
		draw_set_color(c_white); draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_alpha(1 * alphaMod);
		draw_text(bx1, by1, str);
	}
	else if isShowingCompletedQuests {
		draw_sprite(spr,1,xx,yy);
	} else if !isShowingCompletedQuests {
		draw_sprite_ext(spr,1,xx,yy,1,1,0,c_gray,1);
	}
}

// quest watch button
var watchSprite = spr_quest_watch; 
var wsh = sprite_get_height(watchSprite); var wsw = sprite_get_width(watchSprite);
var xx = sqBottomRightX-wsw-5; var yy = sqTopLeftY+3
var x1 = xx; var y1 = yy; var x2 = xx+wsw; var y2 = yy+wsh;
	
if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) {
	audio_play_sound(snd_ui_option_change,1,0);
	draw_sprite_ext(watchSprite,1,xx,yy,1,1,0,c_black,1);
	if watchedQuest == selectedQuest {
		watchedQuest = noone;
	} else {
		watchedQuest = selectedQuest;
	}
}
else if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left) {
	draw_sprite_ext(watchSprite,1,xx,yy,1,1,0,c_dkgray,1);
}
else if mouseOverGuiRect(x1,y1,x2,y2) {
	draw_sprite_ext(watchSprite,1,xx,yy,1,1,0,c_dkgray,.75);
		
	// draw a little explanation for the button
	var str = selectedQuest == watchedQuest ? "Unwatch Quest" : "Watch Quest";
	draw_set_font(font_main);
	var strW = string_width(str);
	var strH = string_height(str);
	draw_set_color(c_black); draw_set_alpha(.5 * alphaMod);
	var bx1 = mouse_x - vx;  var by1 = mouse_y - vy - 15;
	draw_rectangle(bx1, by1, bx1 + strW, by1 + strH, 0);
	draw_set_color(c_white); draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_alpha(1 * alphaMod);
	draw_text(bx1, by1, str);
}
else if watchedQuest == noone || watchedQuest != selectedQuest {
	draw_sprite(watchSprite,1,xx,yy);
} else if watchedQuest == selectedQuest {
	draw_sprite_ext(watchSprite,1,xx,yy,1,1,0,c_gray,1);
}

// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if ui.currentMenu == SKILLS && isActive {
	// controller prompts
	if gamepad_is_connected(pad) {
		if selectedQuest != noone && selectedQuest.currentQuestStep != noone && selectedQuest.currentQuestStep.isRewardStep && !selectedQuest.isFinished {
			w += drawPrompt("Complete " + string(selectedQuest.name), Input.F,promptsStartX+w,promptsY)+xOffset;
		}
		if selectedQuest != noone && selectedQuest.isRepeatable && selectedQuest.isFinished {
			w += drawPrompt("Repeat " + string(selectedQuest.name), Input.Backspace,promptsStartX+w,promptsY)+xOffset;
		}
		if selectedQuest != noone && watchedQuest != selectedQuest {
			w += drawPrompt("Watch " + string(selectedQuest.name), Input.Face4,promptsStartX+w,promptsY)+xOffset;
		}
		if selectedQuest != noone && watchedQuest == selectedQuest {
			w += drawPrompt("Unwatch " + string(selectedQuest.name), Input.Face4,promptsStartX+w,promptsY)+xOffset;
		}
		if isShowingCompletedQuests {
			w += drawPrompt("Hide Completed Quests", Input.Shift,promptsStartX+w,promptsY)+xOffset;
		} else {
			w += drawPrompt("Show Completed Quests", Input.Shift,promptsStartX+w,promptsY)+xOffset;
		}
		w += drawPrompt("Browse Skills", Input.LB,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Close Menu", Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
}

draw_set_alpha(1);