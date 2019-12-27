if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	associatedElevator != noone && !associatedElevator.elevatorIsMoving && associatedElevator.elevatorCurrentFloor != floorNum && distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Call Elevator",Input.F, noone, noone, noone, noone, true);
}