/// scr_quest_sth_step2(npc)
/// @param npc the npc just spoken with

var npc = argument[0];
var sth = instance_nearest(x, y, obj_quest_savingtheholidays);


if instance_exists(sth) && sth.currentQuestStepIndex == 0 {
	var qstep = sth.currentQuestStep;
	qstep.status = QuestStepStatus.Completed;
	
	var secondStep = ds_list_find_value(sth.questSteps, 1);
	if npc == obj_npc_santa {
		secondStep.description = "Speak with David in Hannukah Village, west of Winter Wonderground";
	} else {
		secondStep.description = "Speak with Santa in Christams Town, east of Winter Wonderground";
	}
}

/*
with obj_npc_parent {
	refreshNpcConversations();
}