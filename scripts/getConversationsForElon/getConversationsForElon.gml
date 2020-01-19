/// getConversationsForElon(convList)
/// @param convList

var conversationsList = argument[0];

// intro speech
ds_list_add(conversationsList, scr_conv_elon_intro());

// add muskoxfeeder to list if player not have muskox feeder quest
var mfQuest = instance_nearest(x, y, obj_quest_muskoxfeeder);
if !instance_exists(mfQuest) {
	ds_list_add(conversationsList, scr_conv_elon_muskoxfeeder());
}

// Muskox feeder quest TODO

// Flavor conversations, todo
ds_list_add(conversationsList, scr_conv_elon_directions());
ds_list_add(conversationsList, scr_conv_elon_icewyrms());
ds_list_add(conversationsList, scr_conv_elon_curse());