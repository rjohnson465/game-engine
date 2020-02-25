/// scr_evl_helpinghershel_1_success(arr)
/// @param arr

// called by first quest step of helping hershel quest, when any event is succeeded

var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_hershel {
	// queststep succeeded!
	status = QuestStepStatus.Completed;
	
	with obj_npc_parent {
		refreshNpcConversations();
	}
}