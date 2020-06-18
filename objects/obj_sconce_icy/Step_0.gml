event_inherited();
var p = global.player;
if !(isItemEquipped(obj_hand_item_torch)) && !isLit {
	// maybeRemoveObjectFromInteractionList(id);
	removeFromInteractablesList();
	exit;
}
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

maybeAddOrRemoveFromInteractablesList(20);

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-90,p.facingDirection+90,angleToSconce);

if !isFacing {
	removeFromInteractablesList();
}

if	isFacing && 
	// distance_to_object(obj_player) < 20 && 
	p.currentInteractableObject == id &&
	origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isLit && isItemEquipped(obj_hand_item_torch) {
		lightSconce();
	}
	// extinguish flame
	else if isLit {
		isLit = false;
		extinguishSconce();
	}
} 