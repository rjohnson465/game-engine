if global.playerDoNothing exit;

event_inherited();

if layerToMoveTo != noone {
	layer = layer_get_id(layerToMoveTo);
	playerLightRadius.layer = layer;
	playerLightRadius.depth = layer_get_depth(layer);
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

audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
walkingInWaterEmitter = audio_emitter_create();
audio_emitter_gain(walkingInWaterEmitter,0);
audio_play_sound_on(walkingInWaterEmitter,snd_water_floating_loop,1,0);


