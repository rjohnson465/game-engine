// if there exists an npc_data object for this npc, redo items list based on items in memory
// with "owner" set to this npc
with obj_npc_data {
	if npcName == other.name {
		other.npcData = id;
	}
}

if !instance_exists(npcData) || npcData == noone {
	global.npc = id;
	npcData = instance_create_depth(x,y,1,obj_npc_data);
}

refreshNpcConversations();

// update layer
layer = layer_get_id(npcData.layerName);