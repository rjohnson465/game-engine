/// lightSconce()

/// MUST BE CALLED BY SCONCE OBJECT!!!

isLit = true;
audio_emitter_gain(soundEmitter,MAXGAIN);
torchSoundId = audio_play_sound_on(soundEmitter, torchSound,1,1);
updatePersistentElementProperty(id, "isLit", true);
audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
with lightRadius {
	var floorNum = getLayerFloorNumber(other.origLayer);
	light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
}