if !instance_exists(owner) || !object_is_ancestor(owner.object_index, obj_npc_parent) {
	with obj_npc_parent {
		if name == other.ownerNpcName {
			other.owner = id;
		}
	}
}