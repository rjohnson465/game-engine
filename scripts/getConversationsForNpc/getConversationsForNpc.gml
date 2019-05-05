/// getConversationsForNpc(npcName)
/// @param npcName

/// Called in Room Start event for npc's
/// Figure out which conversations to give to the NPC, based on narrative state (and maybe quest state?)
/// Returns a list

var npcName = argument[0];

var conversationsList = ds_list_create();

switch npcName {
	case "The Elder, Barry": {
		ds_list_add(conversationsList, scr_conv_barry_honesty());
		ds_list_add(conversationsList, scr_conv_barry_welcome());
		ds_list_add(conversationsList, scr_conv_barry_unfairyslayer());
		
		var unfairySlayerQuest = instance_nearest(x, y, obj_quest_unfairyslayer); 
		if instance_exists(unfairySlayerQuest) {
			// if unfairy slayer is done, add the thank you conversation
			if unfairySlayerQuest.currentQuestStep.isRewardStep {
				ds_list_add(conversationsList, instance_create_depth(x, y, 1, obj_conv_unfairyslayer_thankyou));
			}
		}
		
		break;
	}
}

return conversationsList;