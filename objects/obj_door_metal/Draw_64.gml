if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	!isOpen && global.player.isAlive && layer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Open Door",Input.F);
}