/// refreshNpcConversations()

// get an array of all possible conversations for this NPC, based on Narrative State and other factors
var possibleConversations = getConversationsForNpc(name);
if ds_exists(possibleConversations, ds_type_list) {
	for (var i = 0; i < ds_list_size(possibleConversations); i++) {
		var c = ds_list_find_value(possibleConversations, i);
		
		// if this conversation already exist in the npc's conversations property, destroy it (mem leak)
		for (var j = 0; j < ds_list_size(conversations); j++) {
			var c2 = ds_list_find_value(conversations, j);
			if instance_exists(c2) && instance_exists(c) {
				if c2.name == c.name && c != c2 {
					instance_destroy(c,1);
				}
			}
		}
		
		if !instance_exists(c) {
			continue;
		}
		
		// it's possible this conversation "c" is not in the npcData at all yet, 
		// which means we certainly must add it to the NPC's conversations
		var neverFoundCInData = true;
		// now check with npcData object if this conversation has been finished already
		if npcData != noone && ds_exists(npcData.conversations, ds_type_map) {
			var ck = ds_map_find_first(npcData.conversations); 
			for (var j = 0; j < ds_map_size(npcData.conversations); j++) {
				if !instance_exists(c) continue;
				// make sure this is the same conversation as "c"
				if c.name != ck {
					ck = ds_map_find_next(npcData.conversations, ck);
					continue;
				}
				neverFoundCInData = false;
				var isFinished = ds_map_find_value(npcData.conversations, ck);
				if !isFinished {
					// if it's not finished, add it to the NPC's conversations list 
					ds_list_add(conversations, c);
				} else if instance_exists(c) {
					// if it is finished, destroy the conversation instance to preserve memory
					instance_destroy(c); 
				}
				ck = ds_map_find_next(npcData.conversations, ck);
			}
		} 
		if neverFoundCInData && instance_exists(c) {
			ds_list_add(conversations, c);
			// also add it to npc data object
			if instance_exists(npcData) {
				// entry is just <conversation name>, <isFinished>
				ds_map_add(npcData.conversations, c.name, false);
			}
		}
	}
}

ds_list_destroy(possibleConversations); possibleConversations = -1; // mem leak

// if the NPC has items, set up their buy/sell convo
if items != noone {
	// buy / sell
	var bs = instance_create_depth(x,y,1,obj_conversation_parent);
	bs.isRepeatable = true;

	bs.name = "Buy / Sell Items";
	var bs1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
	bs1.func = buySell;
	ds_list_add(bs.steps,bs1);
	ds_list_add(conversations,bs);
}

// push "leave" to the last conversations index
var leaveIndex = noone;
for (var i = 0; i < ds_list_size(conversations); i++) {
	var conv = ds_list_find_value(conversations,i);
	if conv.name == "Leave" leaveIndex = i;
}
var leave = ds_list_find_value(conversations,leaveIndex);
ds_list_delete(conversations,leaveIndex);
ds_list_add(conversations,leave);