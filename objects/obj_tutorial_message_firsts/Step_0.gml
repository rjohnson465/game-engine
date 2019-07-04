var interactInputReceived = keyboard_check_pressed(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_pressed(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

if interactInputReceived && hasSetAlarm {
	instance_destroy(id,1);
	global.isReadingTutorial = false;
	audio_play_sound(snd_ui_tab2,1,0);
	global.player.currentInteractableObject = noone;
	global.player.interactableResetFrame = 5;
	exit;
}