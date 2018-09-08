/// maybeRemoveObjectFromInteractionList(obj)
/// @param obj

var obj = argument[0];

if isObjectInInteractionList(obj) {
	var index = ds_list_find_index(global.player.nonPriorityInteractionPrompts, obj.key);
	ds_list_delete(global.player.nonPriorityInteractionPrompts, index);
}