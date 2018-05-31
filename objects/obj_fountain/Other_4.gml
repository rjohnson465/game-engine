
// re-renter room and fountain has been actived before
//fountainData = findPersistentRoomElementData(obj_fountain_data,id);

if fountainData == noone {
	global.fountain = id;
	instance_create_depth(x,y,1,obj_fountain_data);
}

with obj_fountain_data {
	if key == other.key {
		other.postX = postX;
		other.postY = postY;
		other.isDoneFilling = isDoneFilling;
		if isDoneFilling {
			other.isRunning = true;
		}
		other.fountainData = id;
	}
}

if isRunning || (global.player.justRevivedAtFountain && distance_to_object(obj_player) < 100) {
	sprite_index = asset_get_index("spr_fountain_full");
	isDoneFilling = true;
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);
}

