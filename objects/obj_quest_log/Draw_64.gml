var p = global.player;
var pad = p.gamePadIndex;

draw_set_font(font_main);
if watchedQuest != noone && instance_exists(watchedQuest) && ds_exists(watchedQuest.questSteps,ds_type_list) {
	// is the HUD showing (clickable shit for menus for m/k?)
	var yy = 15;
	if !gamepad_is_connected(pad) {
		yy += sprite_get_height(spr_hud_inventory)+30;
	}
	var xl = view_get_wport(view_camera[0])-(4.5*sprite_get_width(spr_hud_inventory)); var xr = view_get_wport(view_camera[0])-15;
	var xx = mean(xl,xr);
	var xw = xr-xl;
	draw_set_halign(fa_center); draw_set_valign(fa_top);
	scr_draw_text_outline(xx,yy,watchedQuest.name,c_ltgray,c_white,1,1,0,c_black);
	
	if !watchedQuest.isFinished {
		scr_draw_text_outline_ext(xx,yy+string_height(watchedQuest.name)+15,watchedQuest.currentQuestStep.description,c_ltgray,c_white,1,1,0,c_black,-1,xw);
	} else {
		scr_draw_text_outline_ext(xx,yy+string_height(watchedQuest.name)+15,"Quest complete!",c_ltgray,c_white,1,1,0,c_black,-1,xw);
	}
	
}

if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,1);

if !isActive && gamepad_is_connected(p.gamePadIndex) draw_set_alpha(.5);
else draw_set_alpha(1);

// active quests header
draw_set_color(c_black);
draw_rectangle(aqTopLeftX,aqTopLeftY,aqBottomRightX,aqTopLeftY+handlesHeight,1);
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

for (var i = scrollLevel; i < ds_list_size(p.quests); i++) {
	
	draw_set_halign(fa_center); draw_set_valign(fa_bottom);
	var maxW = aqBottomRightX-aqTopLeftX-2-scrollBarWidth;
	var quest = ds_list_find_value(p.quests,i); // TODO account for scroll / offset
	var s = quest.name; var sh = string_height_ext(s,-1,maxW); var sw = string_width_ext(s,-1,maxW);
	
	cumY += sh+5;
	if cumY > maxY break;
	
	lastQuestIndexShown++; drawnQuestsCount++;
	// get quest text coordinates
	var xx = mean(aqTopLeftX,aqBottomRightX-scrollBarWidth); var yy = cumY;
	var x1 = xx-(.5*sw); var y1 = yy-(sh);
	var x2 = xx+(.5*sw); var y2 = yy;
	
	// update text color based on mouse hover
	if //(point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		mouseOverGuiRect(x1,y1,x2,y2) || selectedQuest == quest
	{
		draw_set_color(c_white);
	} else {
		draw_set_color(c_ltgray);
	}
	
	// actually draw the quest name
	draw_text_ext(xx,yy,s,-1,maxW);
	
	// if click on quest name, make that the selected quest
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex) && mouse_check_button_pressed(mb_left) {
		selectedQuest = quest;
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

// draw selected quest info
if selectedQuest != noone && ds_exists(selectedQuest.questSteps,ds_type_list) {
	// selected quest header (quest selected);
	draw_set_color(c_black);
	draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,1);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqTopLeftY+handlesHeight),selectedQuest.name);
	
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
	}
	else if watchedQuest == noone || watchedQuest != selectedQuest {
		draw_sprite(watchSprite,1,xx,yy);
	} else if watchedQuest == selectedQuest {
		draw_sprite_ext(watchSprite,1,xx,yy,1,1,0,c_gray,1);
	}
	
	// draw quest description
	var maxW = sqBottomRightX-sqTopLeftX-5;
	var sh = string_height_ext(selectedQuest.description,-1,maxW); var sw = string_width_ext(selectedQuest.description,-1,maxW);
	draw_set_halign(fa_left); draw_set_valign(fa_top); var yy = sqTopLeftY+handlesHeight;
	draw_text_ext(sqTopLeftX+5,yy,selectedQuest.description,-1,maxW)
	
	// draw each quest step
	var cumY = yy+sh;
	for (var i = 0; i < ds_list_size(selectedQuest.questSteps); i++) {
		var step = ds_list_find_value(selectedQuest.questSteps,i);
		//var sh = string_height("test");
		var s = step.description; var sh = string_height_ext(s,-1,maxW);
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
				
				var buttonColor = c_dkgray;
				var textColor = c_ltgray;
				
				// update text/button color based on mouse hover
				if //(point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) 
					mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && !gamepad_button_check(pad,gp_face1))
				{
					buttonColor = C_HANDLES; textColor = c_white;
				} 
				
				// update text/button color based on mouse click
				else if //(point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) && mouse_check_button(mb_left)
					(mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left)) || (gamepad_is_connected(pad) && gamepad_button_check(pad,gp_face1))
				{
					buttonColor = c_black; textColor = c_white;
				} 
				
				draw_set_color(buttonColor);
				draw_rectangle(x1,y1,x2,y2,0);
				
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
				draw_set_color(C_HANDLES);
			} else {
				draw_set_color(c_dkgray);
			}
			
			draw_rectangle(x1,y1,x2,y2,0);
			draw_set_color(c_white);
			draw_text(xx,yy,"Repeat Quest");
			
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

// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if ui.currentMenu == SKILLS && isActive {
	// controller prompts
	if gamepad_is_connected(pad) {
		if selectedQuest != noone && selectedQuest.currentQuestStep.isRewardStep && !selectedQuest.isFinished {
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
		w += drawPrompt("Browse skills", Input.LB,promptsStartX+w,promptsY)+xOffset;
	}
}