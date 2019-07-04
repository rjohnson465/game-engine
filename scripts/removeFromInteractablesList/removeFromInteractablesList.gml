/// removeFromInteractablesList

var p = global.player;
if !instance_exists(p) exit;
var index = ds_list_find_index(p.interactableObjects, id);
if index != -1 {
	ds_list_delete(p.interactableObjects, index);
}

// maybe reset the current interactable object
if p.currentInteractableObject == id {
	p.currentInteractableObject = noone;
	p.interactableResetFrame = 5;
	if ds_list_size(p.interactableObjects) && p.interactableResetFrame <= 0 {
		p.currentInteractableObject = ds_list_find_value(p.interactableObjects, 0);
	}
}