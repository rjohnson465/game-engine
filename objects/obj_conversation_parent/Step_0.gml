if !instance_exists(owner) || !object_is_ancestor(owner.object_index, obj_npc_parent) {
	with obj_npc_parent {
		if name == other.ownerNpcName {
			other.owner = id;
		}
	}
}

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
			} else if pStep.func != noone && pStep.funcParam1 != noone {
				script_execute(pStep.func, pStep.funcParam1);
			}
		}
		
		if currentStep == ds_list_size(steps)-1 {
			if step.func != noone && step.funcParam1 == noone {
				script_execute(step.func);
			} else if step.func != noone && step.funcParam1 != noone {
				script_execute(step.func, step.funcParam1);
			}
		}
		
		currentSound = step.sound;
		audio_play_sound_at(currentSound,owner.x,owner.y,0,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
	
	
	if currentStep >= ds_list_size(steps)-1 && !audio_is_playing(currentSound) {
		isActive = false;
		isFinished = true;
		owner.isInConversation = false;

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
	
	// also, be sure to mark, in NPC data, that the conversation is finished, and thus,
	// should never be loaded again the next time the NPC is in a room
	with obj_npc_data {
		if npcName == other.ownerNpcName {
			var c = ds_map_find_value(conversations,other.name);
			if c != -1 && c != noone && c != undefined {
				ds_map_replace(conversations,other.name,other.isFinished);
			}
			
			/*
			// if this conv was in the npc's data.conversationsToAdd, remove it from there too
			if ds_list_size(conversationsToAdd) > 0 {
				for (var i = 0; i < ds_list_size(conversationsToAdd); i++) {
					var cName = ds_list_find_value(conversationsToAdd, i);
					var convName = object_get_name(other.object_index);
					if cName == convName {
						ds_list_delete(conversationsToAdd, i);
					}
				}
			} */
			
		}
	}
	instance_destroy(id,1);
}

