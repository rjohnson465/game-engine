var p = global.player;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-90,p.facingDirection+90,angleToSconce);
if isFacing && p.currentInteractableObject == id && distance_to_object(obj_player) < 20 && p.isAlive && origLayer == p.layer && !isInConvo && !global.isInteractingWithNpc {
	if !isLit && p.rightHandItem.object_index == obj_hand_item_torch {
		drawPrompt("Light Sconce",Input.F, noone, noone, noone, noone, true);
	} 
	// extinguish 
	else if isLit {
		drawPrompt("Extinguish Flame",Input.F, noone, noone, noone, noone, true);
	}
}

