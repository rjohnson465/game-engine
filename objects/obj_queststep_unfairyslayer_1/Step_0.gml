event_inherited();
if status != QuestStepStatus.InProgress exit;

with obj_enemy_unfairy {
	if isDying && dyingFrame == 1 {
		other.unfairiesSlain++;
		other.d2 = string(other.unfairiesSlain) + "/3 unfairies slain";
		other.description = other.d1+other.d2;
		var c = c_yellow;
		if other.unfairiesSlain == 3 c = c_lime;
		//alert("Quest update: " + other.quest.name + "\n" + other.d2,c);
		alertQuestUpdate(other.quest,other.d2,c);
	}
}

if unfairiesSlain == 1 {
	status = QuestStepStatus.Completed;
}