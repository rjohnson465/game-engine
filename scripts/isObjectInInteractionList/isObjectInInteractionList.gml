/// isObjectInInteractionList(obj)
/// @param obj

var obj = argument[0];
with obj {
	var p = global.player; 
	var list = p.nonPriorityInteractionPrompts;
	for (var i = 0; i < ds_list_size(list); i++) {
		var k = ds_list_find_value(list,i);
		if k == key {
			return true; // this persistent object's key is already in the list, waiting to be interacted with
		}
	}
	return false;
}