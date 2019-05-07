/// updateNarrativeState(state) 
/// @param state

// update the NarrativeState, which may affect special hat defenses, npc conversations, and more

var ns = argument[0];

global.player.narrativeState = ns;

with obj_hat_parent {
	updateSpecialHatDefensesAndProperties();
}

with obj_npc_parent {
	refreshNpcConversations();
}