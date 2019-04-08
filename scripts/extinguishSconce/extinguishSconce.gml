/// extinguishSconce()

/// MUST BE CALLED BY SCONCE OBJECT!!!

isLit = false;
audio_emitter_gain(soundEmitter,0);
audio_stop_sound(torchSound); torchSound = noone;
updatePersistentElementProperty(id, "isLit", false);
audio_play_sound_at(snd_magic_fire_hit,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
// might need to do more to make the light radius fuck off
instance_destroy(lightRadius,1);
light_destroy_layer(getLayerFloorNumber(origLayer),lightRadius);