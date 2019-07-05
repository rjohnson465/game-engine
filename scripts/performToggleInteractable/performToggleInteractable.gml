/// performToggleInteractable

// must be called by player 
// toggle to the next interactable object in the list, if there is one

if global.isWishing || global.isLooting || global.isInteractingWithNpc || global.isReadingTutorial exit;

with obj_npc_parent {
	if isInConversation {
		exit;
	}
}

if ds_list_size(interactableObjects) == 0 {
	currentInteractableObject = noone; exit;
}

if ds_list_size(interactableObjects) == 1 {
	currentInteractableObject = ds_list_find_value(interactableObjects, 0); exit;
}

var index = ds_list_find_index(interactableObjects, currentInteractableObject);
var newIndex = (index + 1) mod ds_list_size(interactableObjects);
currentInteractableObject = ds_list_find_value(interactableObjects, newIndex);

audio_play_sound(snd_ui_option_change, 1, 0);