// on room start, create an instance of obj_room_data if there is not one fot this room yet
var roomDataObj = noone;
with obj_room_data {
	if roomIndex == room {
		roomDataObj = id;
	}
}

if roomDataObj == noone {
	instance_create_depth(x,y,1,obj_room_data);
}

if layerToMoveTo != noone {
	layer = layer_get_id(layerToMoveTo);
}

// handles layer shading
updateRoomLayers();
