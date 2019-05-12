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

if distance_to_object(obj_player) < 20 && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isActive && !associatedElevator.elevatorIsMoving && associatedElevator.elevatorCurrentFloor != floorNum {
		isActive = true;
		associatedElevator.elevatorFloorToMoveTo = floorNum;
	}
} 