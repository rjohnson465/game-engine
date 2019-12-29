/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var rewardItemsActive = false;
if instance_number(obj_item_reward) > 0 rewardItemsActive = true;

if global.player.isAlive && !global.isWishing && !global.ui.isShowingMenus && !rewardItemsActive && !isInConvo {
	// draw a progress bar for hits given
	draw_set_font(font_main);
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	var str = "Dodges Performed: ";
	var xx = messageTopLeftX + string_width(str);
	var yy = messageBottomRightY + string_height(str) + 5;
	var w = messageBottomRightX - xx; var h = 6;
	var perc = (dodgesPerformed / 3) * 100;
	
	scr_draw_text_outline(messageTopLeftX, yy, str, c_aqua, c_white);
	drawProgressBar(xx, yy, w, h, perc, c_silver, c_aqua);
}