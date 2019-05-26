/// getConversationsForBarry(convList)
/// @param convList

var conversationsList = argument[0];

ds_list_add(conversationsList, scr_conv_barry_honesty());
ds_list_add(conversationsList, scr_conv_barry_welcome());
		
var unfairySlayerQuest = instance_nearest(x, y, obj_quest_unfairyslayer); 
if !instance_exists(unfairySlayerQuest) {
	ds_list_add(conversationsList, scr_conv_barry_unfairyslayer());
}
if instance_exists(unfairySlayerQuest) {
	// if unfairy slayer is done, add the thank you conversation
	if unfairySlayerQuest.currentQuestStep.isRewardStep {
		ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_unfairyslayer_thankyou));
	}
}

var wamdkQuest = instance_nearest(x, y, obj_quest_wamdk);
if !instance_exists(wamdkQuest) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_wamdk_start));
}