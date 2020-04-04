// draw the current event step instruction
if status != EventStepStatus.InProgress exit;
event.isShowingAMessage = false;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var rewardItemsActive = false;
if instance_number(obj_item_reward) > 0 rewardItemsActive = true;

if global.player.isAlive && !global.isWishing && !global.ui.isShowingMenus && !rewardItemsActive && !isInConvo {

	
	var xx = -1; var yy = -1;
	var xl = view_get_wport(view_camera[0])-(4.5*sprite_get_width(spr_hud_inventory)); 
	var xr = view_get_wport(view_camera[0])-15;
	var xx = mean(xl,xr);
	var xw = xr-xl;
	draw_set_halign(fa_center); draw_set_valign(fa_top);
	draw_set_font(font_main); draw_set_color(c_white);
	
	// is the HUD showing (clickable shit for menus for m/k?)
	var yy = 15;
	if !gamepad_is_connected(global.gamePadIndex) {
		yy += sprite_get_height(spr_hud_inventory)+30;
	}
	
	/// account for watched quest
	with obj_quest_log {
		if watchedQuest != noone && instance_exists(watchedQuest) && ds_exists(watchedQuest.questSteps,ds_type_list) {
			
			
			// scr_draw_text_outline_ext(xx, yy, watchedQuest.name, c_fuchsia, c_silver, 1.25, 1.25, 0, c_black, -1, xw);
			var titleHeight = string_height_ext(watchedQuest.name, -1, xw);
			yy += titleHeight;
	
			if !watchedQuest.isFinished && watchedQuest.currentQuestStep != noone {
				// scr_draw_text_outline_ext(xx,yy+titleHeight+15,watchedQuest.currentQuestStep.description,c_ltgray,c_white,1,1,0,c_black,-1,xw);
				yy += string_height_ext(watchedQuest.currentQuestStep.description, -1, xw);
			} else {
				// scr_draw_text_outline_ext(xx,yy+titleHeight+15,"Quest complete!",c_ltgray,c_white,1,1,0,c_black,-1,xw);
				yy += string_height("Quest complete!");
			}
	
			yy += 25;
	
			// separator line
			draw_set_alpha(.85);
			draw_set_color(c_silver);
			draw_rectangle(xx - (xw*.5), yy, xx + (xw * .5), yy + 5, false);
			yy += 25; 
	
		}
	}
	
	
	draw_set_alpha(1);
	// draw Event title
	scr_draw_text_outline_ext(xx, yy, event.eventName, c_aqua, c_silver, 1.25, 1.25, 0, c_black, -1, xw);
	var titleHeight = string_height_ext(event.eventName, -1, xw);
	yy += titleHeight;
	yy += 15;

	// draw event step
	scr_draw_text_outline_ext(xx, yy, message, c_white, c_white, 1, 1, 0, c_black, -1, xw);
	
	yy += string_height_ext(message, -1, xw);
	yy += 15;

	/*
	// hershel health bar
	var hershel = instance_nearest(x, y, obj_hershel);
	if instance_exists(hershel) {
		var perc = hershel.hp / hershel.maxHp;
		perc *= 100;
		draw_healthbar(xx- (.5*xw), yy, xx + (.5 * xw), yy + sh + 5, perc, c_white, c_aqua, c_aqua, 0, false, false);
		draw_set_color(c_silver);
		draw_rectangle(xx- (.5*xw), yy, xx + (.5 * xw), yy + sh + 5, true);
		scr_draw_text_outline(mean(xx - (.5*xw), xx + (.5 * xw)), mean(yy, yy + sh + 5), "Hershel", c_white, c_white);
	} */
}
