/// scr_ablandsgate_roomstart_check

var sth = instance_nearest(x, y, obj_quest_savingtheholidays);

if instance_exists(sth) {
	if !sth.isFinished && sth.currentQuestStepIndex < 6 {
		isUntraversable = true;
	}
	else {
		isUntraversable = false;
	}
	
}