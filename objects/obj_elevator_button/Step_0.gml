var p = global.player;

var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if associatedElevator != noone && !associatedElevator.elevatorIsMoving && associatedElevator.elevatorCurrentFloor != floorNum {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	// distance_to_object(obj_player) < 20 && 
	p.currentInteractableObject == id &&
	origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isActive && !associatedElevator.elevatorIsMoving && associatedElevator.elevatorCurrentFloor != floorNum {
		isActive = true;
		associatedElevator.elevatorFloorToMoveTo = floorNum;
		removeFromInteractablesList();
		audio_play_sound_at(snd_elevator_button, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
	}
} 