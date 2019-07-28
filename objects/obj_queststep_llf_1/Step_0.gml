event_inherited();

if status == QuestStepStatus.Completed && ds_exists(eventListeners, ds_type_map) && ds_map_size(eventListeners) > 0 {
	ds_map_clear(eventListeners);
}

if status != QuestStepStatus.InProgress exit;

// most of this is handled in the event listener 