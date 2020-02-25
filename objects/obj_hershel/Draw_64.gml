if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if	global.player.currentInteractableObject == id &&
	inventoryContainsItem(obj_item_clayheart) &&
	!isActive && global.player.isAlive && layer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Awaken Hershel",Input.F, noone, noone, noone, noone, true);
}


if isActive && !isGoingToAri {
	var perc = hp / 100;
	perc *= 100;
	draw_healthbar(x, y, x + 100, y + 10, perc, c_black, c_red, c_red, 0, true, true);
}