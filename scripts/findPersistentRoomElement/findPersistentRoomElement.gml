/// findPersistentRoomElement(type,postX,postY)
/// @param type
/// @param postX
/// @param postY

var type = argument0;
var px = argument1;
var py = argument2;

with type {
	if postX == px && postY == py {
		return id;
	}
} 

return noone;

