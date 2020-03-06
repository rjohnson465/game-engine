var q = instance_nearest(x, y, obj_quest_savingtheholidays);
if !instance_exists(q) || q == noone || q == undefined || !variable_instance_exists(q, "currentQuestStepIndex") {
	x = -1000; y = -1000;
	exit;
}

if q.currentQuestStepIndex < 3 || q.isFinished {
	x = -1000; y = -1000;
}

wanders = false;