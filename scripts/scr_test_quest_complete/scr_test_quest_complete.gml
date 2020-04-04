/// scr_test_quest_complete(questObjIndex)
/// @param questObjIndex

var questObjIndex = argument[0];

questStart(questObjIndex, false);

var q = instance_nearest(x, y, questObjIndex);

if instance_exists(q) {
	// set every step of the quest to complete
	for (var i = 0; i < ds_list_size(q.questSteps); i++) {
		var qs = ds_list_find_value(q.questSteps, i);
		qs.status = QuestStepStatus.Completed;
		if qs.isRewardStep {
			q.currentQuestStep = qs;
		}
	}
	
	// complete the quest, getting quest reward item(s) (but not xp?)
	completeQuest(q, false);
}