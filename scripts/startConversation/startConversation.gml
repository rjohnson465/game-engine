/// startConversation(conversation)
/// @param conversation

var conv = argument[0];

/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer || global.isTrading exit;

if conv {
	if	!conv.isFinished ||
		(conv.isFinished && conv.isRepeatable)
	{
		if audio_is_playing(greeting) {
			audio_stop_sound(greeting);
		}
		isInConversation = true;
		global.isInteractingWithNpc = false;
		conv.currentStep = noone;
		conv.isActive = true;
		isFinished = false;
	}
}