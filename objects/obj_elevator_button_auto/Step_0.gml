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

if associatedElevator != noone && !associatedElevator.elevatorIsMoving {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	p.currentInteractableObject == id && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isActive && !associatedElevator.elevatorIsMoving {
		isActive = true;
		var pFloorNum = getLayerFloorNumber(p.layer);
		var floors = associatedElevator.elevatorAutoFloors;
		var floorToMoveTo = floors[0] == pFloorNum ? floors[1] : floors[0];
		associatedElevator.elevatorFloorToMoveTo = floorToMoveTo;
		removeFromInteractablesList();
		audio_play_sound_at(snd_elevator_button, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
	}
} 