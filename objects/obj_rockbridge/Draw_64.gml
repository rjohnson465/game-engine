if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	// isCurrentInteractableObject 
	global.player.currentInteractableObject == id
	&& !isActive
	&& distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {

	drawPrompt("Push Boulder",Input.F, noone, noone, noone, noone, true);

}