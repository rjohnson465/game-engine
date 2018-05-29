if !global.ui.isShowingMenus || global.ui.currentMenu != SKILLS || !isActive exit;
var pad = global.player.gamePadIndex;
var p = global.player;

if isActive && gamepad_is_connected(pad) {

	if gamepad_button_check_pressed(pad,gp_padl) {
		isActive = false;
		global.skillManager.isActive = true;
	}
	
	// scroll down quest log
	if gamepad_button_check_pressed(pad,gp_padd) && selectedQuest != noone {
		var qIndex = ds_list_find_index(p.quests,selectedQuest);
		if qIndex != ds_list_size(p.quests) - 1 {
			selectedQuest = ds_list_find_value(p.quests,qIndex+1);
			// if this quest is not currently displayed, scroll down
			if qIndex+1 > lastQuestIndexDisplayed {
				scrollLevel++;
			}
		}
	}
	
	// scroll up quest log
	if gamepad_button_check_pressed(pad,gp_padu) && selectedQuest != noone {
		var qIndex = ds_list_find_index(p.quests,selectedQuest);
		if qIndex > 0 {
			selectedQuest = ds_list_find_value(p.quests,qIndex-1);
			if qIndex-1 <= (lastQuestIndexDisplayed-questsDisplayedCount) {
				scrollLevel--;
			}
		}
	}
	
	// complete quest
	if gamepad_button_check_released(pad,gp_face1) && selectedQuest != noone {
		if selectedQuest.currentQuestStep.isRewardStep && !selectedQuest.isFinished {
			completeQuest(selectedQuest);
		}
	}
	
	// repeat quest (if possible)
	if gamepad_button_check_pressed(pad,gp_face3) && selectedQuest != noone && selectedQuest.isFinished && selectedQuest.isRepeatable {
		repeatQuest(selectedQuest);
	}
	
	// watch quest 
	if gamepad_button_check_released(pad,gp_face4) && selectedQuest != noone {
		if watchedQuest != selectedQuest {
			watchedQuest = selectedQuest;
		} else {
			watchedQuest = noone;
		}
	}
	
	// switch to skills
	if gamepad_button_check_pressed(pad,gp_shoulderlb) {
		isActive = false;
		global.skillManager.isActive = true;
	}
}