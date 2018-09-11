event_inherited();
postX = x;
postY = y;
key = fs_generate_key();
data = noone;
with obj_persistent_environment_data_parent {
	if key == other.key {
		other.data = id;
	}
}

isNonPriorityInteractable = false;
isCurrentInteractableObject = false;
