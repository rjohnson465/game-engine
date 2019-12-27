if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if	global.player.currentInteractableObject == id &&
	!isFed && instance_number(obj_quest_muskoxfeeder) > 0 &&
	distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Feed Elon's Muskox",Input.F, noone, noone, noone, noone, true);
}