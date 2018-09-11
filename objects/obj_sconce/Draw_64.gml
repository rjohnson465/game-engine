var p = global.player;
//if p.rightHandItem.object_index != obj_hand_item_torch exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-45,p.facingDirection+45,angleToSconce);
if isFacing && isCurrentInteractableObject && distance_to_object(obj_player) < 20 && p.isAlive && layer == p.layer && !isInConvo && !global.canLoot && !global.canInteractWithNpc && !global.isInteractingWithNpc {
	if !isLit && p.rightHandItem.object_index == obj_hand_item_torch {
		drawPrompt("Light Sconce",Input.F);
	} 
	// extinguish 
	else if isLit {
		drawPrompt("Extinguish Flame",Input.F);
	}
}

