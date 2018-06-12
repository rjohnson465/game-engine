/// findPersistentRoomElementData(type, elementId)
/// @param type A persistenet element data type -- i.e. obj_persistent_environment_data_parent
/// @param elementId

var type = argument0;
var el = argument1;

with type {
	if postX == el.postX && postY == el.postY {
		return id;
	}
}

return noone;