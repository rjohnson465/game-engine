
if global.el != noone {
	el = global.el;
	key = fs_generate_key(el);
	postX = el.postX;
	postY = el.postY;
	roomIndex = string(room);
}
else {
	el = noone;
	key = noone;
	postX = noone;
	postY = noone;
	roomIndex = noone;
}

with obj_room_data {
	if string(roomIndex) == string(other.roomIndex) {
		ds_map_replace(persistentElements,other.key,other.id);
	}
}
properties = ds_map_create();