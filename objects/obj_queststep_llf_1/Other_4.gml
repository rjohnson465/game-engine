if status == QuestStepStatus.Completed exit;
// this is for loading 
var wc = ds_map_find_value(parameters, "wiresCount");
if wc == undefined {
	wc = 0;
	ds_map_replace(parameters, "wiresCount", 0);
}
if status != QuestStepStatus.Completed {
	description = "Find the 3 elevator wires for Robort to fix the elevator.\n Found " + string(wc) + "/3 wires.";
} else {
	description = "Find the 3 elevator wires for Robort to fix the elevator.\n Found 3/3 wires.";
}

// if wires count is 3, this quest step is completed
if wc >= 3 && status == QuestStepStatus.InProgress {
	status = QuestStepStatus.Completed;
	ds_map_clear(eventListeners);
	with obj_npc_rob {
		refreshNpcConversations();
	}
}