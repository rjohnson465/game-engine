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

// we should definitely just be storing lightweight JSON data for each
// npc's item list, this is shit
/*
if npcData != noone && npcData.hasInitializedItems {
	ds_list_clear(items);
	for (var i = 0; i < ds_list_size(npcData.inventory); i++) {
		var item = ds_list_find_value(npcData.inventory, i);
		ds_list_add(items, item);
	}
}
// ensure all items are "owned" by this npc
else if items != noone && items != undefined && ds_exists(items,ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		item.owner = id;
	}
} */

// set conversations based on data
// This could be a memory leak? We should update conversations by loading in 
// data from a file. Really need JSON data for each NPC
if npcData != noone && ds_exists(npcData.conversations, ds_type_map) {
	var ck = ds_map_find_first(npcData.conversations); 
	for (var i = 0; i < ds_map_size(npcData.conversations); i++) {
		var isFinished = ds_map_find_value(npcData.conversations, ck);
		if isFinished {
			// find the conversation in the npc's convos list and delete it
			for (var j = 0; j < ds_list_size(conversations); j++) {
				var conv = ds_list_find_value(conversations, j);
				if conv.name == ck {
					ds_list_delete(conversations, j);
				}
			}
		}
		ck = ds_map_find_next(npcData.conversations, ck);
	}
}

// add any "conversations to add" to conversations list, if they exist in npc data
if npcData != noone && ds_exists(npcData.conversationsToAdd, ds_type_list) {
	for (var i = 0; i < ds_list_size(npcData.conversationsToAdd); i++) {
		var convName = ds_list_find_value(npcData.conversationsToAdd, i);
		var convObjIndex = asset_get_index(convName);
		if convObjIndex != -1 {
			// make sure there is not already an instance of this conversation in conversations list
			var alreadyHasConv = false;
			for (var j = 0; j < ds_list_size(conversations); j++) {
				var c = ds_list_find_value(conversations, j);
				var oi = c.object_index;
				if oi == convObjIndex {
					alreadyHasConv = true;
				}
			}
			if !alreadyHasConv {
				var convObj = instance_create_depth(x,y,1,convObjIndex);
				ds_list_add(conversations, convObj);
			}
		}
	}
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