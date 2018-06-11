/// fs_save_npcs
/// returns a map of all the npc data in the game
var sd_npcs = ds_map_create();
with obj_npc_data {
	var sd_npc = ds_map_create();
	
	ds_map_replace(sd_npc,"NpcName",npcName);
	ds_map_replace(sd_npc,"NpcObjIndex",npcObjIndex);
	ds_map_replace(sd_npc,"NpcObjIndexName",npcObjIndexName);
	ds_map_replace(sd_npc,"HasInitializedItems",hasInitializedItems);
	
	// TODO this needs to be fomatted correctly -- save conversation data
	ds_map_add_map(sd_npc,"Conversations",conversations);
	
	//var key = fs_generate_key(enemy);

	ds_map_add_map(sd_npcs,npcObjIndexName,sd_npc);
}

return sd_npcs;