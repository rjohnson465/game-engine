if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if	global.player.currentInteractableObject == id &&
	distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Feed Muskox",Input.F);
}