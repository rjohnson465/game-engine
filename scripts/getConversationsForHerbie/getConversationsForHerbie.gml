/// getConversationsForAri(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech -- only if saving herbie quest not active yet, or on step 1
var savingherbie = instance_nearest(x, y, obj_quest_savingherbie);
if (!instance_exists(savingherbie) || savingherbie.currentQuestStepIndex == 0) {
	ds_list_add(conversationsList, scr_conv_herbie_intro());
}

var event = instance_nearest(x, y, obj_event_saving_herbie);
if instance_exists(savingherbie) && savingherbie.currentQuestStepIndex == 1 && (!instance_exists(event)) {
	ds_list_add(conversationsList, scr_conv_herbie_start_escort());
}
