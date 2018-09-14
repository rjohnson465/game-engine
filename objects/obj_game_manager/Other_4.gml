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