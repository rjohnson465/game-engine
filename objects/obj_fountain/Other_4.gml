/*// on room start, create an instance of obj_room_data if there is not one fot this room yet
var roomDataObj = noone;
with obj_room_data {
	if roomIndex == room {
		roomDataObj = id;
	}
}

if roomDataObj == noone {
	instance_create_depth(x,y,1,obj_room_data);
}*/

// re-renter room and fountain has been actived before
fountainData = findPersistentRoomElementData(obj_fountain_data,id);
if isRunning || (global.player.justRevivedAtFountain && distance_to_object(obj_player) < 100) {
	sprite_index = asset_get_index("spr_fountain_full");
	isDoneFilling = true;
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);
}

