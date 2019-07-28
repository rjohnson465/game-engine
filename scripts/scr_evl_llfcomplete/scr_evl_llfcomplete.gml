/// scr_evl_wires(questCompletedArr)
/// @parm itemPickedUp

/// EventListener for wires pickup in Lamplight Factory

// This listener is stored in the eventListenersMap for the first quest step of the Investigate LLF quest

var questCompletedArr = argument[0];
var quest = questCompletedArr[0];

if !instance_exists(quest) || !object_is_ancestor(quest.object_index, obj_quest_parent) exit;

if quest.object_index == obj_quest_llf {
	updateNarrativeState(NarrativeState.WinterWonderground);
}
