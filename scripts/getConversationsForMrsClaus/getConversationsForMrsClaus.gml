/// getConversationsForMrsClaus(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech
ds_list_add(conversationsList, scr_conv_mrsclaus_intro());

// savingherbiestart -- if saving herbie doesn't exist yet
var sh = instance_nearest(x, y, obj_quest_savingherbie);
if !instance_exists(sh) {
	ds_list_add(conversationsList, scr_conv_mrsclaus_shs());
}

// mid step of sh quest (repeatable dialogue)
if (instance_exists(sh) && !sh.isFinished && sh.currentQuestStepIndex == 1) {
	ds_list_add(conversationsList, scr_conv_mrsclaus_shm());
}

// end step of sh quest
if (instance_exists(sh) && !sh.isFinished && sh.currentQuestStepIndex == 2) {
	ds_list_add(conversationsList, scr_conv_mrsclaus_she());
}

// Flavor conversations
ds_list_add(conversationsList, scr_conv_mrsclaus_krampus());
ds_list_add(conversationsList, scr_conv_mrsclaus_ablands());