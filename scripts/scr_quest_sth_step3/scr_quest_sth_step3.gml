/// scr_quest_sth_step3(npc)
/// @param npc the npc just spoken with

var npc = argument[0];
var sth = instance_nearest(x, y, obj_quest_savingtheholidays);

if instance_exists(sth) && sth.currentQuestStepIndex == 1 {
	var qstep = sth.currentQuestStep;
	qstep.status = QuestStepStatus.Completed;
}

