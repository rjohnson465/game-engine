/// getConversationsForSanta(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech -- if saving the holidays quest on step 0
var sth = instance_nearest(x, y, obj_quest_savingtheholidays);
if instance_exists(sth) && sth.currentQuestStepIndex == 0 {
	ds_list_add(conversationsList, scr_conv_santa_intro());
}

// intro speech, if saving the holodays quest on step 1 (already spoke with david)
if (instance_exists(sth) && sth.currentQuestStepIndex == 1) {
	var desc = sth.currentQuestStep.description;
	// description must include the word 'Santa'
	if string_pos("Santa", desc) {
		ds_list_add(conversationsList, scr_conv_santa_intro2());
	}
}

// fetch step of sth quest (repeatable dialogue)
if (instance_exists(sth) && sth.currentQuestStepIndex == 2) {
	ds_list_add(conversationsList, scr_conv_santa_sthf());
}

// stars are received step of sth
if (instance_exists(sth) && sth.currentQuestStepIndex == 3) {
	ds_list_add(conversationsList, scr_conv_santa_sths());
}


// Kill krampus quest, if not active yet
var kQuest = instance_nearest(x, y, obj_quest_krampus); 
if !instance_exists(kQuest) {
	ds_list_add(conversationsList, scr_conv_santa_krampus());
}

// Kill Krampus complete step, if krampus quest is at reward step
if instance_exists(kQuest) && kQuest.currentQuestStep.isRewardStep {
	ds_list_add(conversationsList, scr_conv_santa_krampus_complete());
}

// Flavor conversations
ds_list_add(conversationsList, scr_conv_santa_krampuselves());