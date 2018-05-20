var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.canLoot && !global.isWishing && !global.ui.isShowingMenus && !global.canInteractWithNpc && !isInConvo {
	if !isRunning {
		drawPrompt("Fill Fountain",Input.F);
	}
	if isDoneFilling {
		drawPrompt("Wish At Fountain",Input.F);
	}
}
