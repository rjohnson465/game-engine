if isShowingMenus {
	isShowingMenus = false;
	moveSelector.isActive = true;
	equipSelector.isActive = false;
	imbueSelector.isActive = false;
	equipSelector.acceptableEquipmentSlots = [];
	cursor_sprite = -1;
} else {
	showHideOptions();
}
audio_play_sound(snd_ui_click1,1,0);