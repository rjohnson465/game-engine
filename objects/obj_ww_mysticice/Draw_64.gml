if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	global.player.currentInteractableObject == id &&
	!isOpen && global.player.isAlive && layer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Melt Ice",Input.F);
}