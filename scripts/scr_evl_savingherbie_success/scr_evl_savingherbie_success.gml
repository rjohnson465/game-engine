/// scr_evl_savingherbie_success(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	
	var sh = instance_nearest(x, y, obj_quest_savingherbie);
	sh.currentQuestStep.status = QuestStepStatus.Completed;
	
	with obj_npc_parent {
		refreshNpcConversations();
	}
}