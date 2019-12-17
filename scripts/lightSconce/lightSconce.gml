        /// lightSconce(soundToPlay*)
/// @param soundToPlay*

var soundToPlay = snd_magic_fire_shoot;
if argument_count > 0 {
	soundToPlay = argument[0];
}

if lightRadius != noone exit;

/// MUST BE CALLED BY SCONCE OBJECT!!!
// (or get cheeky and use the lamplight obj lol)


isLit = true;
if object_index == obj_sconce || object_is_ancestor(object_index, obj_sconce) {
	audio_emitter_gain(soundEmitter,MAXGAIN);
	torchSoundId = audio_play_sound_on(soundEmitter, torchSound,1,1);
}
var rd = instance_nearest(x,y,obj_room_data);
if rd != noone {
	updatePersistentElementProperty(id, "isLit", true);
} else {
	ds_map_replace(properties, "isLit", true);
}
if soundToPlay > 0 {
	audio_play_sound_at(soundToPlay,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
}
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
with lightRadius {
	var floorNum = getLayerFloorNumber(other.origLayer);
	light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
}