/// scr_evl_wires(itemPickedUpArr)
/// @parm itemPickedUp

/// EventListener for wires pickup in Lamplight Factory

// This listener is stored in the eventListenersMap for the first quest step of the Investigate LLF quest

var itemPickedUpArr = argument[0];
var item = itemPickedUpArr[0];

if !instance_exists(item) || !object_is_ancestor(item.object_index, obj_item_parent) exit;

// increment the wires count parameter of this quest step
if item.object_index == obj_item_wire_b || item.object_index == obj_item_wire_r || item.object_index == obj_item_wire_w {
	var wc = ds_map_find_value(parameters, "wiresCount");
	ds_map_replace(parameters, "wiresCount", wc+1);
	
	// update the description for this quest step
	var wc = ds_map_find_value(parameters, "wiresCount");
	description = "Find the 3 elevator wires for Robort to fix the elevator.\n Found " + string(wc) + "/3 wires.";

	alertQuestUpdate(quest, description);

	// if wires count is 3, this quest step is completed
	if wc >= 3 {
		status = QuestStepStatus.Completed;
		ds_map_clear(eventListeners);
		with obj_npc_rob {
			refreshNpcConversations();
		}
	}
}
