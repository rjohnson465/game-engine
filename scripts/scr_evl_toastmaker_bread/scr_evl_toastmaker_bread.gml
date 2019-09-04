/// scr_evl_toastmaker_bread(itemPickedUpArr)
/// @parm itemPickedUp

/// EventListener for bread pickup in Lamplight Factory

// This listener is stored in the eventListenersMap for the first quest step of the Toast Maker quest

var itemPickedUpArr = argument[0];
var item = itemPickedUpArr[0];

if !instance_exists(item) || !object_is_ancestor(item.object_index, obj_item_parent) exit;

// increment the wires count parameter of this quest step
if item.object_index == obj_item_bread {
	
	var bc = ds_map_find_value(parameters, "breadCount");
	ds_map_replace(parameters, "breadCount", bc+1);
	
	// update the description for this quest step
	var bc = ds_map_find_value(parameters, "breadCount");
	description = string(bc) + "/4 bread found";

	alertQuestUpdate(quest, description);

	// if bread count is 4, this quest step is completed
	if bc >= 4 {
		status = QuestStepStatus.Completed;
		ds_map_clear(eventListeners);
		with obj_npc_terri {
			refreshNpcConversations();
		}
	}
}

