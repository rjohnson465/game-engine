/// getConversationsForRob(convList)
/// @param convList

var conversationsList = argument[0];

ds_list_add(conversationsList, scr_conv_rob_elevator());

// add llf to conversations, if player has just begun llf quest
var llfQuest = instance_nearest(x, y, obj_quest_llf);
var wamdkQuest = instance_nearest(x, y, obj_quest_wamdk);
var llfQuestStep0 = instance_nearest(x, y, obj_queststep_llf_0);
if !instance_exists(llfQuest) || (instance_exists(llfQuestStep0) && llfQuestStep0.status = QuestStepStatus.InProgress) || (wamdkQuest.currentQuestStep.isRewardStep && !wamdkQuest.isFinished) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_investigate_llf_start));
}

// add "Good you fixed the elevator" recognition conversation (nonrepeatable) if all wires in inventory
var llfQuestStep1 = instance_nearest(x, y, obj_queststep_llf_1);
var llfQuestStep2 = instance_nearest(x, y, obj_queststep_llf_2);
if	instance_exists(llfQuestStep1) && llfQuestStep1.status == QuestStepStatus.Completed 
	&& instance_exists(llfQuestStep2) && llfQuestStep2.status != QuestStepStatus.Completed
	&& !llfQuest.isFinished {
	ds_list_add(conversationsList, scr_conv_rob_elevator_fixed());
}

var llfQuestStep2 = instance_nearest(x, y, obj_queststep_llf_2);
if instance_exists(llfQuestStep2) && llfQuestStep2.status == QuestStepStatus.Completed && !llfQuest.isFinished {
	ds_list_add(conversationsList, scr_conv_rob_llfe());
}

ds_list_add(conversationsList, scr_conv_rob_lamplights());
ds_list_add(conversationsList, scr_conv_rob_factory());
ds_list_add(conversationsList, scr_conv_rob_otherrobots());