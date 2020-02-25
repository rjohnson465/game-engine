/// scr_event_fail(event)
/// @param event

var ev = id;
if argument_count > 0 {
	ev = argument[0];
}

/// must be called by an event object
with ev {
	alert(eventName + " failed!", c_red);
	instance_destroy(id, 1);
	
	raiseEvent(EV_EVENT_FAILED, [id]);
}