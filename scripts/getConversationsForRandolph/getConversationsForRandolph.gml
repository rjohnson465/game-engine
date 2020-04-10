/// getConversationsForRandolph(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech -- only if saving herbie quest not active yet, or on step 1
var rl = instance_nearest(x, y, obj_quest_reindeerlove);
if (!instance_exists(rl)) {
	ds_list_add(conversationsList, scr_conv_randolph_rils());
}

// reindeer in love in progress conv
if (instance_exists(rl) && rl.currentQuestStepIndex == 0) {
	ds_list_add(conversationsList, scr_conv_randolph_rilip());
}

// reindeer in love completed conv
if (instance_exists(rl) && rl.currentQuestStepIndex == 1 && !rl.isFinished) {
	ds_list_add(conversationsList, scr_conv_randolph_rile());
}

// flavor conversations
ds_list_add(conversationsList, scr_conv_randolph_vixen());
ds_list_add(conversationsList, scr_conv_randolph_mysticice());