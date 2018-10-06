/// fs_save_npcs
/// returns a map of all the npc data in the game
var sd_npcs = ds_map_create();
with obj_npc_data {
	var sd_npc = ds_map_create();
	
	ds_map_replace(sd_npc,"NpcName",npcName);
	ds_map_replace(sd_npc,"NpcObjIndex",npcObjIndex);
	ds_map_replace(sd_npc,"NpcObjIndexName",npcObjIndexName);
	ds_map_replace(sd_npc,"HasInitializedItems",hasInitializedItems);
	
	// clone the conversations map, otherwise we're gonna destroy it at the end of fs_save
	var conversations_clone = ds_map_deep_clone(conversations);
	ds_map_add_map(sd_npc,"Conversations",conversations_clone);
	// save the conversationsToAdd list
	var cta = ds_list_create();
	ds_list_copy(cta, conversationsToAdd);
	ds_map_add_list(sd_npc, "ConversationsToAdd", cta);

	ds_map_add_map(sd_npcs,npcObjIndexName,sd_npc);
}

return sd_npcs;