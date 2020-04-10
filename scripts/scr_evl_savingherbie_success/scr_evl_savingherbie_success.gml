/// scr_evl_savingherbie_success(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	
	var mc = instance_nearest(x, y, obj_npc_mrsclaus);
	if instance_exists(mc) {
		mc.isInteractable = true;
	}
	var herbie = instance_nearest(x, y, obj_npc_herbie);
	if instance_exists(herbie) {
		herbie.isSolid = true;
	}
	
	var sh = instance_nearest(x, y, obj_quest_savingherbie);
	sh.currentQuestStep.status = QuestStepStatus.Completed;
	
	with obj_npc_parent {
		refreshNpcConversations();
	}
}