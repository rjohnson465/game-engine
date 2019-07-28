// this is for loading 
var bc = ds_map_find_value(parameters, "breadCount");
if status != QuestStepStatus.Completed {
	description = string(bc) + "/4 bread found";
} else {
	description = "0/4 bread found";
}

// if wires count is 3, this quest step is completed
if bc >= 3 && status == QuestStepStatus.InProgress {
	status = QuestStepStatus.Completed;
	ds_map_clear(eventListeners);
	with obj_npc_terri {
		refreshNpcConversations();
	}
}