var interactInputReceived = keyboard_check_pressed(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_pressed(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

if isActive && (interactInputReceived || distance_to_object(obj_player) > 20) {
	isActive = false;
	global.isReadingTutorial = false;
	audio_play_sound(snd_ui_tab2,1,0);
	exit;
}

if global.isLooting || global.isInteractingWithNpc || global.isWishing || global.isTrading || global.isReadingTutorial exit;

if isCurrentInteractionObject(id) && distance_to_object(obj_player) < 20 && origLayer == global.player.layer && interactInputReceived {
	if !isActive {
		audio_play_sound(snd_ui_tab2,1,0);
	}
	isActive = true;
	global.isReadingTutorial = true;
}
