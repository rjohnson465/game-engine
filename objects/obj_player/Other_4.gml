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

if justRevivedAtFountain {
	justRevivedAtFountain = false;
	var f = instance_nearest(x,y,obj_fountain);
	with f {
		if !isRunning {
			isRunning = true;
			isDoneFilling = true;
			//fountainData.isDoneFilling = true;
			sprite_index = asset_get_index("spr_fountain_full");
		}
		respawnEnemies();
	}
}

// handles layer shading
updateRoomLayers();

isShowingLightRadius = true;

