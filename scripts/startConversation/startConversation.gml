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
		conv.alarm[0] = conv.CONV_SKIP_DELAY_FRAMES;
		conv.canBeSkipped = false;
		isFinished = false;
	}
}