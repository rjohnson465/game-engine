event_inherited();
if status != QuestStepStatus.InProgress exit;

with obj_enemy_unfairy {
	
	//if isDying && dyingFrame == 1 {
	if deathFrameFlag {
		//other.unfairiesSlain++;
		ds_map_replace(other.parameters,"unfairies_slain",ds_map_find_value(other.parameters,"unfairies_slain")+1);
		other.description = "Slain " + string(ds_map_find_value(other.parameters,"unfairies_slain")) + "/3 unfairies";
		var c = c_yellow;
		if ds_map_find_value(other.parameters,"unfairies_slain") == 3 c = c_lime;
		alertQuestUpdate(other.quest,other.description,c);
	}
}

if ds_map_find_value(other.parameters,"unfairies_slain") == 3 {
	
	// add a "thank you" conversation to Francis' data object
	with obj_npc_data {
		if npcName == "Francis" {
			ds_list_add(conversationsToAdd, object_get_name(obj_conv_unfairyslayer_thankyou));
		}
	}
	
	// force room start event for npcs to add conversations to
	with obj_npc_parent {
		event_perform(ev_other, ev_room_start);
	}
	
	status = QuestStepStatus.Completed;
}
