/// scr_savingherbie_herbie_found

// if player doesn't have saving herbie quest yet, give it to them

if instance_number(obj_quest_savingherbie) == 0 {
	questStart(obj_quest_savingherbie);
}

// set first quest step to complete
var savingherbie = instance_nearest(x, y, obj_quest_savingherbie);

with savingherbie {
	var q0 = currentQuestStep;
	q0.status = QuestStepStatus.Completed;
	
	// currentQuestStepIndex = 1;
	// currentQuestStep = ds_list_find_value(questSteps,1);
}