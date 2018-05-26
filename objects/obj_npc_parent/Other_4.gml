

// if there exists an npc_data object for this npc, redo items list based on items in memory
// with "owner" set to this npc
var npcDataObj = noone;
with obj_npc_data {
	if npc.name == other.name {
		npcDataObj = id;
	}
}

if npcDataObj != noone && npcDataObj.hasInitializedItems {
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