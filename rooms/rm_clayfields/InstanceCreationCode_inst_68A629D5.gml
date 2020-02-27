var sth = instance_nearest(x, y, obj_quest_savingtheholidays);

if instance_exists(sth) {
	if !sth.isFinished && sth.currentQuestStepIndex < 5 {
		isUntraversable = true;
	}
	else {
		isUntraversable = false;
	}
	
}