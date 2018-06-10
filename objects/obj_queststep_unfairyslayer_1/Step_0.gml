event_inherited();
if status != QuestStepStatus.InProgress exit;

with obj_enemy_unfairy {
	if isDying && dyingFrame == 1 {
		//other.unfairiesSlain++;
		ds_map_replace(other.parameters,"unfairies_slain",ds_map_find_value(other.parameters,"unfairies_slain")+1);
		other.description = "Slain " + string(ds_map_find_value(other.parameters,"unfairies_slain")) + "/3 unfairies";
		var c = c_yellow;
		if ds_map_find_value(other.parameters,"unfairies_slain") == 3 c = c_lime;
		alertQuestUpdate(other.quest,other.description,c);
	}
}

if ds_map_find_value(other.parameters,"unfairies_slain") == 3 {
	status = QuestStepStatus.Completed;
}
