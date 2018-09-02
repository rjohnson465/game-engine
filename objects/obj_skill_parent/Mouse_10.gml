if global.ui.currentMenu != SKILLS || !global.ui.isShowingMenus exit;

with obj_skill_selector {
	if selectedSkill != other {
		audio_play_sound(snd_ui_option_change,1,0);
	}
}

obj_skill_selector.x1 = x1;
obj_skill_selector.y1 = y1;