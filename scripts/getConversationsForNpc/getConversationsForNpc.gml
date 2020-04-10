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
	case "Robort": {
		getConversationsForRob(conversationsList);
		break;
	}
	case "Terri the Toaster": {
		getConversationsForTerri(conversationsList);
		break;
	}
	case "Elon": {
		getConversationsForElon(conversationsList);
		break;
	}
	case "Casino Guard": {
		getConversationsForCasinoGuard(conversationsList);
		break;
	}
	case "Santa": {
		getConversationsForSanta(conversationsList);
		break;
	}
	case "David": {
		getConversationsForDavid(conversationsList);
		break;
	}
	case "Ari": {
		getConversationsForAri(conversationsList);
		break;
	}
	case "Herbie the Elf": {
		getConversationsForHerbie(conversationsList);
		break;
	}
	case "Mrs. Claus": {
		getConversationsForMrsClaus(conversationsList);
		break;
	}
	case "Randolph, the Red-Nosed Reindeer": {
		getConversationsForRandolph(conversationsList);
		break;
	}
}

return conversationsList;