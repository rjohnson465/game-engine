if !isInConversation {
	isInteractingWithPlayer = false;
	showBuySell = false;
	global.isInteractingWithNpc = false;
	global.isTrading = false;
	with obj_npc_parent {
		refreshNpcConversations();
	}
}