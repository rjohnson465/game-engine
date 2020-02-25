/// scr_evl_helpinghershel_1_fail(arr)

// called by first quest step of helping hershel quest, when any event is failed

var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_hershel {
	// change current quest description
	description = "Hershel ripped out his heart to avoid possession. Speak with Ari.";
	
	with obj_npc_parent {
		refreshNpcConversations();
	}
}