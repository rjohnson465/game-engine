/// scr_event_fail(event)
/// @param event

var ev = id;
if argument_count > 0 {
	ev = argument[0];
}

/// must be called by an event object
with ev {
	alert(eventName + " failed!", c_red);
	isActive = false;
	updatePersistentElementProperty(id, "isActive", false);
	
	// maybe stop event bgm 
	if eventBgm != noone && audio_exists(eventBgm) {
		with global.gameManager.bgmManager {
			startBgm();
		}
	}
	
	raiseEvent(EV_EVENT_FAILED, [id]);
	
	instance_destroy(id, 1);
}