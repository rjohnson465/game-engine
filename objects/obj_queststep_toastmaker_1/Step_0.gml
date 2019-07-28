event_inherited();
if status != QuestStepStatus.InProgress exit;
// most of this is handled in the event listener 

if !hasDoneInitialCheck {

	var isInConvo = false;
	with obj_npc_parent {
		if isInConversation {
			isInConvo = true;
		}
	}
	
	if !isInConvo {
		// check if the player has already found some or all of the wires
		var bc = 0;
		var pinv = global.player.inventory;
		for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
			var item = ds_list_find_value(pinv, i);
			if instance_exists(item) {
				if item.object_index == obj_item_bread {
					bc = item.count;
				}
			}
		}

		// if so, update the initial description
		ds_map_replace(parameters,"breadCount",bc);
		description = string(bc) + "/4 bread found";

		if bc >= 4 {
			status = QuestStepStatus.Completed;
		}
		
		hasDoneInitialCheck = true;
	}

}