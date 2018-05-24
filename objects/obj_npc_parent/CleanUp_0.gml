ds_list_destroy(conversations);

if ds_exists(items,ds_type_list) {
	ds_list_destroy(items);
}

with obj_conversation_parent {
	if owner == other.id {
		instance_destroy(id,1);
	}
}