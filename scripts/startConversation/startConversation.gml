/// startConversation(conversation)
/// @param conversation

var conv = argument[0];

/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer || global.isTrading exit;

if conv {
	if	!conv.isFinished ||
		(conv.isFinished && conv.isRepeatable)
	{
	
		isInConversation = true;
		global.isInteractingWithNpc = false;
		conv.currentStep = noone;
		conv.isActive = true;
		isFinished = false;
	}
}