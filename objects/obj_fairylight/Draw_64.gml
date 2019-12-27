var p = global.player;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-90,p.facingDirection+90,angleToSconce);


if isFacing && p.currentInteractableObject == id && distance_to_object(obj_player) < 20 && p.isAlive && origLayer == p.layer && !isInConvo && !global.isInteractingWithNpc {
	
	if !isLit {
		
		// make sure player has a lamplight in inventory
		if inventoryContainsItem(obj_item_lamplight) {
			drawPrompt("Light Sacred Lamplight",Input.F, noone, noone, noone, noone, true);
		}
	} 
	// steal lamplight back 
	else if isLit {
		drawPrompt("Steal Sacred Lamplight",Input.F, noone, noone, noone, noone, true);
	}
}

