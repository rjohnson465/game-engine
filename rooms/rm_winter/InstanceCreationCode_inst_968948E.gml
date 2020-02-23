var q = instance_nearest(x, y, obj_quest_savingtheholidays);
if !instance_exists(q) {
	x = -1000; y = -1000;
}

if q.currentQuestStepIndex < 3 || q.isFinished {
	x = -1000; y = -1000;
}

wanders = false;