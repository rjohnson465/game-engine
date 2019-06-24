event_inherited();
if status != QuestStepStatus.InProgress exit;

/*
// constantly check if Barry's Key is in inventory
var playerHasKey = false;
with obj_item_key {
	if name == "Barry's Key" && owner == global.player {
		playerHasKey = true;
	}
}*/

if room == rm_boss_funfairy {
	/*if status != QuestStepStatus.Completed {
		updateNarrativeState(NarrativeState.LamplightFactory);
	}*/
	status = QuestStepStatus.Completed;
}
