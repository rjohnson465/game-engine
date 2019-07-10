/// getConversationsForRob(convList)
/// @param convList

var conversationsList = argument[0];

ds_list_add(conversationsList, scr_conv_rob_elevator());

// add llf to conversations, if player does not have this quest already
var llfQuest = instance_nearest(x, y, obj_quest_wamdk);
if !instance_exists(llfQuest) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_investigate_llf_start));
}

ds_list_add(conversationsList, scr_conv_rob_lamplights());
ds_list_add(conversationsList, scr_conv_rob_factory());
ds_list_add(conversationsList, scr_conv_rob_otherrobots());