
el = global.el;
key = fs_generate_key(el);
postX = el.postX;
postY = el.postY;
roomIndex = room;
with obj_room_data {
	if string(roomIndex) == string(other.roomIndex) {
		ds_map_replace(persistentElements,other.key,other.id);
	}
}
properties = ds_map_create();