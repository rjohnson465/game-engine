if global.isReadingTutorial exit;

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if 
	// distance_to_object(obj_player) < 20 && 
	global.player.currentInteractableObject == id &&
	origLayer == global.player.layer && global.player.isAlive && !global.isWishing && !global.ui.isShowingMenus && !isInConvo {
	if !isRunning {
		drawPrompt("Fill Fountain",Input.F, noone, noone, noone, noone, true);
	}
	if isDoneFilling {
		drawPrompt("Wish At Fountain",Input.F, noone, noone, noone, noone, true);
	}
}
