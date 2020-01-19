/// getConversationsForDavid(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech -- if saving the holidays quest on step 0
var sth = instance_nearest(x, y, obj_quest_savingtheholidays);
if instance_exists(sth) && sth.currentQuestStepIndex == 0 {
	ds_list_add(conversationsList, scr_conv_david_intro());
}

// intro speech, if saving the holodays quest on step 1 (already spoke with santa)
if (instance_exists(sth) && sth.currentQuestStepIndex == 1) {
	var desc = sth.currentQuestStep.description;
	// description must include the word 'Santa'
	if string_pos("David", desc) {
		ds_list_add(conversationsList, scr_conv_david_intro2());
	}
}

// fetch step of sth quest (repeatable dialogue)
if (instance_exists(sth) && sth.currentQuestStepIndex == 2) {
	ds_list_add(conversationsList, scr_conv_david_sthf());
}

// stars are received step of sth
if (instance_exists(sth) && sth.currentQuestStepIndex == 3) {
	ds_list_add(conversationsList, scr_conv_david_sths());
}

// gazebo
if (instance_exists(sth) && sth.currentQuestStep == 4) {
	ds_list_add(conversationsList, scr_conv_david_sthg());
}


// Kill amir quest, if not active yet
var kQuest = instance_nearest(x, y, obj_quest_smashingpottery); 
if !instance_exists(kQuest) {
	ds_list_add(conversationsList, scr_conv_david_smashingpottery());
}

// Flavor conversations
ds_list_add(conversationsList, scr_conv_david_golems());
ds_list_add(conversationsList, scr_conv_david_dybukks());