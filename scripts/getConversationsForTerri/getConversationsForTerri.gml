/// getConversationsForTerri(convList)
/// @param convList

var conversationsList = argument[0];

// add llf to conversations, if player does not have this quest already
var toastmakerQuest = instance_nearest(x, y, obj_quest_toastmaker);
if !instance_exists(toastmakerQuest) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_toastmaker_start));
}

// Toastmaker completed conv
var toastMakerQuestStep1 = instance_nearest(x, y, obj_queststep_toastmaker_1);
if instance_exists(toastMakerQuestStep1) && toastMakerQuestStep1.status == QuestStepStatus.Completed /*&& !toastmakerQuest.isFinished*/ {
	ds_list_add(conversationsList, scr_conv_terri_toastmaker_complete());
}

ds_list_add(conversationsList, scr_conv_terri_factoryrobots());
ds_list_add(conversationsList, scr_conv_terri_lighteaterlarvae());