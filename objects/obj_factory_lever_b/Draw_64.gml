if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if isCurrentInteractableObject && distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.canLoot && !global.canInteractWithNpc && !global.isInteractingWithNpc {
	drawPrompt("Flip Lever",Input.F);
}