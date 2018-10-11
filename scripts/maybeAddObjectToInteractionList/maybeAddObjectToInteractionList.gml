/// maybeAddObjectToInteractionList(obj)
/// @param obj

/// maybe add this object to the list of non-explicitly prioritized interactable objects (i.e. doors, sconces)
/// pre-condition -- obj must be a child of persistent room element or have key prop

var obj = argument[0];
var p = global.player; 

/*if !object_is_ancestor(obj.object_index,obj_persistent_environment) {
	alert("Developer Error: Trying to add a non obj_persistent_environment obj to interactable list",c_red);
	exit;
}*/

if isObjectInInteractionList(obj) exit; // object is already waiting to be interacted with, exit
else ds_list_add(p.nonPriorityInteractionPrompts,obj.key);