if !ui.isShowingMenus || ui.currentMenu != SKILLS exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,1);

draw_set_font(font_main);

var p = global.player;

// active quests header
draw_set_color(c_black);
draw_rectangle(aqTopLeftX,aqTopLeftY,aqBottomRightX,aqTopLeftY+handlesHeight,1);
draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(aqTopLeftX,aqBottomRightX),mean(aqTopLeftY,aqTopLeftY+handlesHeight),"Active quests");

// draw active quest names
var s = "test"; var sh = string_height(s);
var maxY = MENUS_BOTTOMRIGHT_Y-sh-10; var cumY = aqTopLeftY+sh;
for (var i = 0; i < ds_list_size(p.quests); i++) {
	
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	var maxW = aqBottomRightX-aqTopLeftX-2;
	var quest = ds_list_find_value(p.quests,i); // TODO account for scroll / offset
	var s = quest.name; var sh = string_height_ext(s,-1,maxW); var sw = string_width_ext(s,-1,maxW);
	
	cumY += sh;
	if cumY > maxY break;
	
	// get quest text coordinates
	var xx = mean(aqTopLeftX,aqBottomRightX); var yy = cumY;
	var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
	var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
	
	// update text color based on mouse hover
	if (point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) ||
		selectedQuest == quest
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

// divider line
draw_set_color(c_black);
draw_line(aqBottomRightX,aqTopLeftY,aqBottomRightX,aqBottomRightY);

// draw selected quest info
if selectedQuest != noone {
	// selected quest header (quest selected);
	draw_set_color(c_black);
	draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,1);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqTopLeftY+handlesHeight),selectedQuest.name + " Progress");
	
	// draw quest description
	var maxW = sqBottomRightX-sqTopLeftX-5;
	var sh = string_height_ext(selectedQuest.description,-1,maxW); var sw = string_width_ext(selectedQuest.description,-1,maxW);
	draw_set_halign(fa_left); draw_set_valign(fa_top); var yy = sqTopLeftY+handlesHeight+20;
	draw_text_ext(sqTopLeftX+5,yy,selectedQuest.description,-1,maxW)
	
	// draw each quest step
	var cumY = yy+sh;
	for (var i = 0; i < ds_list_size(selectedQuest.steps); i++) {
		var step = ds_list_find_value(selectedQuest.steps,i);
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
				var x1 = xx-(.5*sw)-2; var y1 = yy-(.5*sh)-2;
				var x2 = xx+(.5*sw)+2; var y2 = yy+(.5*sh)+2;
				
				var buttonColor = c_dkgray;
				var textColor = c_ltgray;
				
				// update text/button color based on mouse hover
				if (point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) 
				{
					buttonColor = C_HANDLES; textColor = c_white;
				} 
				
				// update text/button color based on mouse click
				else if (point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && !gamepad_is_connected(global.player.gamePadIndex)) && mouse_check_button(mb_left)
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
	
} else {
	// selected quest header (no quest selected);
	draw_set_color(c_black);
	draw_rectangle(sqTopLeftX,sqTopLeftY,sqBottomRightX,sqTopLeftY+handlesHeight,1);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqTopLeftY+handlesHeight),"Quest details");
	
	// no quest selected
	draw_text(mean(sqTopLeftX,sqBottomRightX),mean(sqTopLeftY,sqBottomRightY),"No quest selected");
}

