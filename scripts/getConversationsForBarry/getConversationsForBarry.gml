/// getConversationsForBarry(convList)
/// @param convList

var conversationsList = argument[0];

ds_list_add(conversationsList, scr_conv_barry_honesty());
ds_list_add(conversationsList, scr_conv_barry_welcome());

// add wamdk to conversations, if player does not have this quest already
var wamdkQuest = instance_nearest(x, y, obj_quest_wamdk);
if !instance_exists(wamdkQuest) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_wamdk_start));
}

if instance_exists(wamdkQuest) && (wamdkQuest.currentQuestStep.isRewardStep || wamdkQuest.isFinished) {
	var conv = instance_create_depth(x, y, 1, obj_conv_wamdk_completed);
	// if narrative state is lamplight factory or before, this can be an urgent conv
	if global.player.narrativeState <= NarrativeState.LamplightFactory {
		conv.isUrgent = true;
	}
	ds_list_add(conversationsList, conv);
}