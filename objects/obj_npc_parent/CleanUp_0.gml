if ds_exists(conversations, ds_type_list) {
	ds_list_destroy(conversations); conversations = -1;
}

if ds_exists(items,ds_type_list) {
	ds_list_destroy(items); items = -1;
}

with obj_conversation_parent {
	if owner == other.id {
		instance_destroy(id,1);
	}
}