/// getConversationsForNpc(npcName)
/// @param npcName

/// Called in Room Start event for npc's
/// Figure out which conversations to give to the NPC, based on narrative state (and maybe quest state?)
/// Returns a list

var npcName = argument[0];

var conversationsList = ds_list_create();

switch npcName {
	case "The Elder, Barry": {
		getConversationsForBarry(conversationsList);
		break;
	}
	case "Rob the Robot": {
		getConversationsForRob(conversationsList);
		break;
	}
}

return conversationsList;