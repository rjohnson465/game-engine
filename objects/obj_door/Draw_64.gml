var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if distance_to_object(obj_player) < 20 && global.player.isAlive && layer == global.player.layer && !isInConvo && !global.canLoot && !global.canInteractWithNpc && !global.isInteractingWithNpc {
	drawPrompt("Open Door",Input.F);
}