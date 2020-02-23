/// scr_quest_sth_togazebo

var sth = instance_nearest(x, y, obj_quest_savingtheholidays);

if instance_exists(sth) && sth.currentQuestStepIndex == 3 {
	var qstep = sth.currentQuestStep;
	qstep.status = QuestStepStatus.Completed;
	// remove stars from inventory
	var xmasstar = instance_nearest(x, y, obj_item_xmas_star);
	destroyItem(xmasstar, false);
	var starofdavid = instance_nearest(x, y, obj_item_starofdavid);
	destroyItem(starofdavid, false);
}

