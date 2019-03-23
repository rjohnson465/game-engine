part_emitter_destroy(system,emitter);
part_system_destroy(system); system = -1; emitter = -1;

ds_list_destroy(combatantsHit); combatantsHit = -1;
audio_emitter_gain(soundEmitter, 0);
audio_emitter_free(soundEmitter); soundEmitter = -1;

/*
if isSpell || isSoundLooping {
	audio_stop_sound(sound);
}*/

if isRanged && instance_exists(weapon) && weapon != noone && weapon.isTwoHanded && owner == global.player {
	event_perform(ev_alarm,1);
}

ds_map_destroy(additionalDamages); additionalDamages = -1;