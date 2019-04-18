if global.isReadingTutorial exit;

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if distance_to_object(obj_player) < 20 && origLayer == global.player.layer && global.player.isAlive && !global.canLoot && !global.isWishing && !global.ui.isShowingMenus && !global.canInteractWithNpc && !isInConvo {
	drawPrompt("Wish At Dark Fountain",Input.F);	
}
