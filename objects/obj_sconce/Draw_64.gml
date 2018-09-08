var p = global.player;
if p.rightHandItem.object_index != obj_hand_item_torch exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if isCurrentInteractableObject && !isLit && distance_to_object(obj_player) < 20 && p.isAlive && layer == p.layer && !isInConvo && !global.canLoot && !global.canInteractWithNpc && !global.isInteractingWithNpc {
	drawPrompt("Light Sconce",Input.F);
}