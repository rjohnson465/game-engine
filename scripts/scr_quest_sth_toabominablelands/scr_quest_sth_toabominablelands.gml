/// scr_quest_sth_togazebo

var sth = instance_nearest(x, y, obj_quest_savingtheholidays);

if instance_exists(sth) && sth.currentQuestStepIndex == 4 {
	var qstep = sth.currentQuestStep;
	qstep.status = QuestStepStatus.Completed;
}

