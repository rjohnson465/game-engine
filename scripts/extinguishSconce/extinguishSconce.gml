/// extinguishSconce(soundToPlay*)
/// @param *playSound

/// MUST BE CALLED BY SCONCE OBJECT!!!

var soundToPlay = snd_magic_fire_hit;
if argument_count > 0 {
	soundToPlay = argument[0];
}

isLit = false;
if object_index == obj_sconce || object_is_ancestor(object_index, obj_sconce) {
	audio_emitter_gain(soundEmitter,0);
	audio_stop_sound(torchSound); torchSound = noone;
}
updatePersistentElementProperty(id, "isLit", false);
if soundToPlay > 0 {
	audio_play_sound_at(soundToPlay,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
}
// might need to do more to make the light radius fuck off
instance_destroy(lightRadius,1);
light_destroy_layer(getLayerFloorNumber(origLayer),lightRadius);
lightRadius = noone;