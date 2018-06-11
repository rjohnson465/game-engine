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

if npcData != noone && npcData.hasInitializedItems {
	ds_list_clear(items);
	with obj_item_parent {
		if owner == other {
			ds_list_add(owner.items,id);
		}
	}
}
else // ensure all items are "owned" by this npc
if items != noone && items != undefined && ds_exists(items,ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		item.owner = id;
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