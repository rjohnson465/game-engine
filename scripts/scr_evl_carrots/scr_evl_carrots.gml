/// scr_evl_wires(itemPickedUpArr)
/// @parm itemPickedUp

/// EventListener for carrots pickup in Reindeer Love queststep

var itemPickedUpArr = argument[0];
var item = itemPickedUpArr[0];

if !instance_exists(item) || !object_is_ancestor(item.object_index, obj_item_parent) exit;

if item.object_index == obj_item_carrots {

	status = QuestStepStatus.Completed;
	with obj_npc_parent {
		refreshNpcConversations();
	}
	
}

