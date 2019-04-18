event_inherited();



//audio_emitter_gain(fountainRunningSoundEmitter,1);
//fountainRunningSoundIndex = audio_play_sound_on(fountainRunningSoundEmitter, fountainRunningSound, 1, 1);
var lr = noone;
with obj_light_radius {
	if owner == other.id {
		lr = id;
	}
}
if lr == noone {
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);
}




