if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if	isOpen && 
	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Enter Snowtunnel To " + string(tunnelDestinationName),Input.F);
}