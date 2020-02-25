/// getConversationsForAri(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech -- start his quest
var hh = instance_nearest(x, y, obj_quest_helpinghershel);
if !instance_exists(hh) {
	ds_list_add(conversationsList, scr_conv_ari_helpinghershel_start());
}

// active step of hh quest (repeatable dialogue)
if (instance_exists(hh) && inventoryContainsItem(obj_item_clayheart)) {
	ds_list_add(conversationsList, scr_conv_ari_helpinghershel_ip());
}

// failed hh quest, get more clay (urgent, non-repeatable once have clay
if (instance_exists(hh) && !hh.currentQuestStep.isRewardStep && !inventoryContainsItem(obj_item_clayheart)) {
	ds_list_add(conversationsList, scr_conv_ari_helpinghershel_failed());
}

// succeeded hh quest
if (instance_exists(hh) && hh.currentQuestStep.isRewardStep) {
	ds_list_add(conversationsList, scr_conv_ari_helpinghershel_success());
}

// Flavor conversations
ds_list_add(conversationsList, scr_conv_ari_amir());
ds_list_add(conversationsList, scr_conv_ari_clay());