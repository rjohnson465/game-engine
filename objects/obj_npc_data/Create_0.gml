npc = global.npc;
npcName = "npc name";
npcObjIndex = noone;
npcObjIndexName = "npc object index name";
if instance_exists(npc) {
	npcName = npc.name;
	npcObjIndex = npc.object_index;
	npcObjIndexName = object_get_name(npcObjIndex);
}
conversations = ds_map_create(); // name / isFinished

// TODO --- use this list to add convos to npc that are not made on the create event
// these conversation objects / steps should be persistent -- they must be carried in memory
// until the npc says them. Then they may be destroyed
conversationsToAdd = ds_list_create();

inventory = ds_list_create();

hasInitializedItems = false;
if instance_exists(npc) && ds_exists(npc.items, ds_type_list) {
	for (var i = 0; i < ds_list_size(npc.conversations); i++) {
		var c = ds_list_find_value(npc.conversations,i);
		ds_map_replace(conversations,c.name,c.isFinished);
	}
	
	for (var i = 0; i < ds_list_size(npc.items); i++) {
		var item = ds_list_find_value(npc.items, i );
		ds_list_add(inventory, item);
	}
}

if npc != noone && instance_exists(npc) {
	layerName = layer_get_name(npc.layer);
}