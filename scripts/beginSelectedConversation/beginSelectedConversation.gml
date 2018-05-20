/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer exit;
if selectedConversation {
	if	!selectedConversation.isFinished ||
		(selectedConversation.isFinished && selectedConversation.isRepeatable)
	{
		if audio_is_playing(greeting) {
			audio_stop_sound(greeting);
		}
		isInConversation = true;
		global.isInteractingWithNpc = false;
		selectedConversation.currentStep = noone;
		selectedConversation.isActive = true;
		isFinished = false;
	}
}