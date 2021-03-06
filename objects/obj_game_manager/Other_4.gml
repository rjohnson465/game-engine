if room != game_menu {
	instance_activate_all();
	global.isPopulatingGrids = true;
	alarm[5] = 10;
	populateGrids();
	
	// handles roomStartScript for all objects
	alarm[6] = 15; // "room start" is 5 frames from room start, to allow for respawns
}

// stop all looping sfx
var loopingSfx = [
	snd_magic_fire_charge, snd_magic_magic_charge, snd_magic_ice_charge, 
	snd_magic_poison_charge, snd_magic_lightning_charge
];

for (var i = 0; i < array_length_1d(loopingSfx); i++) {
	var snd = loopingSfx[i];
	if audio_is_playing(snd) audio_stop_sound(snd);
}
// create room data object
currentRoomData = instance_create_depth(x,y,1,obj_room_data);

// stop current amb, start new amb
audio_emitter_free(ambEmitter); ambEmitter = -1;
ambEmitter = audio_emitter_create();
ds_map_clear(ambpFrames); ds_map_clear(ambPeriodicalsMap); ds_map_clear(ambpFrameStarts);
var ck = ds_map_find_first(ambpEmitters);
for (var i = 0; i < ds_map_size(ambpEmitters); i++) {
	var emitter = ds_map_find_value(ambpEmitters, ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(ambpEmitters, ck);
}
ds_map_clear(ambpEmitters);
ambCurrent = noone;
startAmb();


