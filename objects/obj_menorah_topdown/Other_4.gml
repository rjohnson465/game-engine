if isLit {

	audio_emitter_gain(soundEmitter,MAXGAIN);
	torchSoundId = audio_play_sound_on(soundEmitter, torchSound,1,1);

	global.owner = id;
	global.makeLightOnCreate = true;
	lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
	with lightRadius {
		var floorNum = getLayerFloorNumber(other.origLayer);
		light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
	}

}