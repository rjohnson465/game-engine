/// maybeAddOrRemoveFromInteractablesList(distToInteract*)
/// @param *distToInteract

// must be called by some interactable object (item, door, portal...)
var p = global.player;

var l = variable_instance_exists(id, "origLayer") ? origLayer : layer;

if object_is_ancestor(object_index, obj_npc_parent) {
	l = layer;
}

var lName = layer_get_name(l);
var pLayerName = layer_get_name(p.layer);

if l != p.layer exit;

// no interaction allowed in certain states
if global.isReadingTutorial || global.isInteractingWithNpc || global.isLooting || global.isTrading || global.isWishing || p.interactableResetFrame > 0 {
	p.currentInteractableObject = noone;
	exit;
}


var listIndex = ds_list_find_index(p.interactableObjects, id);
var interactDistance = variable_instance_exists(id, "INTERACT_DISTANCE") ? INTERACT_DISTANCE : 20;
if argument_count > 0 {
	interactDistance = argument[0];
}

// if interactable object is close enough to player and not in interact list, add it to list
if distance_to_object(p) <= interactDistance && listIndex == -1 {
	ds_list_add(p.interactableObjects, id);
}

// if interactable object not close enough to player and is still in interact list, remove it from list
if distance_to_object(p) > interactDistance && listIndex != -1 {
	ds_list_delete(p.interactableObjects, listIndex);
}

// retry getting list index (could be -1 if just deleted interactable object)
listIndex = ds_list_find_index(p.interactableObjects, id);
// if listIndex is -1 and the current interactable object is id, change it 
if listIndex == -1 && p.currentInteractableObject == id {
	if ds_list_size(p.interactableObjects) > 0 {
		p.currentInteractableObject = ds_list_find_value(p.interactableObjects, 0);
	} else {
		p.currentInteractableObject = noone;
		p.interactableResetFrame = 5;
	}
}

// if for some reason this interactable object doesnt exist anymore,
// remove it from the list and set p.currentInteractableObject to noone
if !instance_exists(p.currentInteractableObject) {
	var pos = ds_list_find_index(p.interactableObjects, p.currentInteractableObject);
	if pos >= 0 {
		ds_list_delete(p.interactableObjects, pos);
		p.currentInteractableObject = noone;
	}
}

// maybe update current interaction object
if p.currentInteractableObject == noone && ds_list_size(p.interactableObjects) > 0 && p.interactableResetFrame <= 0 {
	p.currentInteractableObject = ds_list_find_value(p.interactableObjects, 0);
}