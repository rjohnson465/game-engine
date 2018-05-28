event_inherited();
if status != QuestStepStatus.InProgress exit;

with obj_enemy_unfairy {
	if isDying && dyingFrame == 1 {
		other.unfairiesSlain++;
		other.description = "Slain " + string(other.unfairiesSlain) + "/3 unfairies";
		var c = c_yellow;
		if other.unfairiesSlain == 3 c = c_lime;
		alertQuestUpdate(other.quest,other.description,c);
	}
}

if unfairiesSlain == 3 {
	status = QuestStepStatus.Completed;
}