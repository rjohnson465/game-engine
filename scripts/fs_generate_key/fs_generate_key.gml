/// fs_generate_key(*inst)
/// @param *inst
/// generate a unique key for any instance
var inst = id;
if argument_count == 1 {
	inst = argument[0];
}
with inst {
	if object_is_ancestor(object_index,obj_enemy_parent) || object_is_ancestor(object_index,obj_persistent_environment) {
		var roomIn = object_index == obj_fountain ? asset_get_index(nativeRoom) : room;
		return room_get_name(roomIn)+";"+object_get_name(object_index)+";"+string(postX)+string(postY);
	} else {
		return room_get_name(room)+object_get_name(object_index)+string(x)+string(y);
	}
}