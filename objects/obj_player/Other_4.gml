if global.playerDoNothing exit;

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
			sprite_index = asset_get_index("spr_fountain_full");
		}
		wishAtFountain(false);
	}
}

// handles layer shading
updateRoomLayers();
isShowingLightRadius = true;


