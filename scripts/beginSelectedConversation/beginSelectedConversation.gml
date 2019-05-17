/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer || global.isTrading exit;
if selectedConversation {
	if	!selectedConversation.isFinished ||
		(selectedConversation.isFinished && selectedConversation.isRepeatable)
	{
		isInConversation = true;
		global.isInteractingWithNpc = false;
		selectedConversation.currentStep = noone;
		selectedConversation.isActive = true;
		isFinished = false;
	}
}