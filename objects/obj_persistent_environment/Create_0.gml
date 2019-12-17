event_inherited();
postX = x;
postY = y;
currentX = x;
currentY = y;
key = fs_generate_key();
data = noone;
isNonPriorityInteractable = false;
isCurrentInteractableObject = false;

if !variable_instance_exists(id, "properties") {
	properties = ds_map_create();
}