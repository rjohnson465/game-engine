if !ds_exists(event.eventSteps,ds_type_list) exit;
if !event.isActive exit;

var pos = ds_list_find_index(event.eventSteps,id);
var nextStep = ds_list_find_value(event.eventSteps,pos+1);
if status == EventStepStatus.Completed && nextStep != undefined && nextStep != noone && instance_exists(nextStep) {
	
	// by default, alert player this event step is completed 
	if nextStep.status == EventStepStatus.Unstarted {
		if !event.isFinished {
			// play a sound to alert player step has ended
			audio_play_sound(snd_sword_draw, 1, 0);
			
			with event {
				part_particles_clear(system);
			}
		}
		nextStep.status = EventStepStatus.InProgress;
		event.currentEventStep = nextStep;
		event.currentEventStep = pos+1;
	}
}

if status == EventStepStatus.Completed && nextStep == undefined && event.isActive {
	// finish event
	with event {
		
		alert("Event Complete: " + eventName, c_aqua);
		audio_play_sound(snd_ui_quest_complete_alert, 1, 0);
		raiseEvent(EV_EVENT_SUCCESS, [id]);
		
		isActive = false;
		isFinished = true;
		if !isRepeatable {
			updatePersistentElementProperty(id, "isFinished", true);
		}
						
		// make associated walls traversable
		for (var i = 0; i < array_length_1d(associatedWallKeys); i++) {
			var wKey = associatedWallKeys[i];
			var w = noone;
			with obj_event_wall {
				if key == wKey {
					w = id;
				}
			}
			if w != noone {
				w.isUntraversable = false;
			}
		}
		
		// destroy exercise instance, which should destroy all its steps
		instance_destroy(id, 1);
	}
}