if global.isReadingTutorial exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

// cannot turn valve if one of its pipes is currently cooling down a floor
var canTurnValve = true;
for (var i = 0; i < ds_list_size(associatedPipes); i++) {
	var pipe = ds_list_find_value(associatedPipes, i);
	with obj_molten_floor {
		if instance_exists(douser) && douser == pipe && isCoolingDown {
			canTurnValve = false;
		}
	}
}

if	canTurnValve && 
	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	distance_to_object(obj_player) < 20 && global.player.isAlive && origLayer == global.player.layer && !isInConvo && !global.isInteractingWithNpc {
	drawPrompt("Turn Valve",Input.F, noone, noone, noone, noone, true);
}