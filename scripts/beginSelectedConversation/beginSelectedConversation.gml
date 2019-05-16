/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer || global.isTrading exit;
if selectedConversation {
	if	!selectedConversation.isFinished ||
		(selectedConversation.isFinished && selectedConversation.isRepeatable)
	{
		var g = greeting;
		if is_array(g) {
			for (var i = 0; i < array_length_1d(g); i++) {
				var gr = g[i];
				if audio_is_playing(gr) {
					audio_stop_sound(gr);
				}
			}
		} else {
	 	
			if audio_is_playing(greeting) {
				audio_stop_sound(greeting);
			}
		}
		isInConversation = true;
		global.isInteractingWithNpc = false;
		selectedConversation.currentStep = noone;
		selectedConversation.isActive = true;
		isFinished = false;
	}
}