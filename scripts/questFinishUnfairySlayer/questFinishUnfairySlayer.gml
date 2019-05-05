/// questFinishUnfairySlayer

var quests = global.player.quests;

obj_quest_unfairyslayer.isFinished = true;

// refreshNpcConversations manually
// if the npc for this quest is not in room, this will be triggered on next Room Start anyway

/*
// add a "thank you" conversation to Francis' data object
with obj_npc_data {
	if name == "Francis" {
		ds_list_add(conversationsToAdd, object_get_name(obj_conv_unfairyslayer_thankyou));
	}
}*/

alertQuestComplete(obj_quest_unfairyslayer);