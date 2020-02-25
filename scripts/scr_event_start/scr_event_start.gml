/// scr_event_start(event)
/// @param event
/// Must be called by an event object

var ev = id;

if argument_count > 0 {
	ev = argument[0];
}

if !instance_exists(ev) && object_exists(ev) {
	ev = instance_create_depth(x, y, 1, ev);
}

with ev {
	if  !isActive && !isFinished {
		
		isActive = true;
		sprite_index = noone;
		alert("Event Started: " + eventName, c_aqua);
		audio_play_sound(snd_sword_draw, 1, 0);
	
		// set all steps to inactive, except the first one
		for (var i = 0; i < ds_list_size(eventSteps); i++) {
			var step = ds_list_find_value(eventSteps, i);
			step.status = ExerciseStepStatus.Unstarted;
		}
	
		currentEventStep = ds_list_find_value(eventSteps,0);
		currentEventStep.status = ExerciseStepStatus.InProgress;
		
		raiseEvent(EV_EVENT_STARTED, [id]);
	}
}