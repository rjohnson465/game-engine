if isActive {
	while (currentStep < ds_list_size(steps)-1 && !audio_is_playing(currentSound)) {
		if currentStep == noone {
			currentStep = 0;
		} else currentStep += 1;
		var step = ds_list_find_value(steps,currentStep);
		
		// perform function of previous step, if it exists
		prevStep = currentStep - 1;
		if prevStep >= 0 {
			var pStep = ds_list_find_value(steps,prevStep);
			if pStep.func != noone {
				script_execute(pStep.func);
			}
		}
		
		if currentStep == ds_list_size(steps)-1 {
			if step.func != noone {
				script_execute(step.func);
			}
		}
		
		currentSound = step.sound;
		audio_play_sound_at(currentSound,owner.x,owner.y,0,100,300,1,0,1);
	}
	
	if currentStep >= ds_list_size(steps)-1 && !audio_is_playing(currentSound) {
		isActive = false;
		isFinished = true;
		owner.isInConversation = false;
		//currentSound = noone;
		if !isRepeatable {
			for (var i = 0; i < ds_list_size(steps); i++) {
				var step = ds_list_find_value(steps,i);
				instance_destroy(step,1);
			}
			var pos = ds_list_find_index(owner.conversations,id);
			ds_list_delete(owner.conversations,pos);
			instance_destroy(id,1);
		}
	}
}

// finished, non-repeatable conversations can be destroyed
if isFinished && !isRepeatable {
	for (var i = 0; i < ds_list_size(steps); i++) {
		var step = ds_list_find_value(steps,i);
		instance_destroy(step,1);
	}
	var pos = ds_list_find_index(owner.conversations,id);
	ds_list_delete(owner.conversations,pos);
	instance_destroy(id,1);
}

