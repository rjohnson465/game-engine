if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	associatedElevator != noone && !associatedElevator.elevatorIsMoving && distance_to_object(obj_player) < 20 && 
	global.player.isAlive && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Use Elevator",Input.F, noone, noone, noone, noone, true);
}