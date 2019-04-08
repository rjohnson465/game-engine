event_inherited();
var p = global.player;
if p.rightHandItem.object_index != obj_hand_item_torch && !isLit {
	maybeRemoveObjectFromInteractionList(id);
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

var angleToSconce = point_direction(p.x,p.y,x,y);
var isFacing = angleBetween(p.facingDirection-45,p.facingDirection+45,angleToSconce);

if isFacing && distance_to_object(obj_player) < 20 && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	if !isLit && p.rightHandItem.object_index == obj_hand_item_torch {
		lightSconce();
	}
	// extinguish flame
	else if isLit {
		isLit = false;
		extinguishSconce();
	}
} 