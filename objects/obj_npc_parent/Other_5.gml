ds_list_destroy(conversations);
with obj_conversation_parent {
	if owner == other.id {
		instance_destroy(id,1);
	}
}