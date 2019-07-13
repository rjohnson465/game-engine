/// getConversationsForRob(convList)
/// @param convList

var conversationsList = argument[0];

// add llf to conversations, if player does not have this quest already
var toastmakerQuest = instance_nearest(x, y, obj_quest_toastmaker);
if !instance_exists(toastmakerQuest) {
	ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_toastmaker_start));
}

ds_list_add(conversationsList, scr_conv_terri_factoryrobots());
ds_list_add(conversationsList, scr_conv_terri_lighteaterlarvae());