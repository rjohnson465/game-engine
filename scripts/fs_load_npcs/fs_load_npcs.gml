/// fs_load_npcs(npcDataMap)
/// @param npcDataMap
/// creates enemy data objects from save game file

// destroy all current enemy data objs
with obj_npc_data {
	instance_destroy(id,1);
}

var sd_npcs = argument[0];
var cv = ds_map_find_first(sd_npcs);
for (var i = 0; i < ds_map_size(sd_npcs); i++) {
	
	var sd_npc = ds_map_find_value(sd_npcs,cv);
	
	var npcDataObj = noone;
	var npcObj = noone;
	with obj_npc_parent {
		if name == ds_map_find_value(sd_npc,"NpcName") {
			npcObj = id;
		}
	}
	if npcObj == noone continue;
	else global.npc = npcObj;
	npcDataObj = instance_create_depth(x,y,1,obj_npc_data);
	
	npcDataObj.name = ds_map_find_value(sd_npc,"NpcName");
	npcDataObj.npcObjIndex = ds_map_find_value(sd_npc,"NpcObjIndex");
	npcDataObj.npcObjIndexName = ds_map_find_value(sd_npc,"NpcObjIndexName");
	var conversations_copy = ds_map_deep_clone(ds_map_find_value(sd_npc, "Conversations"));
	npcDataObj.conversations = conversations_copy;
	
	with obj_npc_parent {
		if name == cv {
			npcData = npcDataObj;
		}
		event_perform(ev_other,ev_room_start);
	}
	
	// this refreshes conversations 
	with npcDataObj {
		event_perform(ev_other,ev_room_start);
	}
	
	cv = ds_map_find_next(sd_npcs,cv);
}