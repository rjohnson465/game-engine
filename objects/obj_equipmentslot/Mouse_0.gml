if alarm[0] == 0 && !hasSetAlarm {
	audio_play_sound(item.soundGrab,1,0);
	global.ui.grabbedItem = item;
	global.ui.grabbedItem.equipmentSlotBeforeDrag = slot;
}