/// startConversation(conversation)
/// @param conversation

var conv = argument[0];

/// must be called from obj_npc_parent


if isInConversation || !isInteractingWithPlayer || global.isTrading exit;

if conv {
	if	!conv.isFinished ||
		(conv.isFinished && conv.isRepeatable)
	{
		/*var g = greeting;
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
		} */
		isInConversation = true;
		global.isInteractingWithNpc = false;
		conv.currentStep = noone;
		conv.isActive = true;
		isFinished = false;
	}
}