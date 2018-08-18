part_emitter_destroy(system,emitter);
part_system_destroy(system); system = -1; emitter = -1;
part_type_destroy(particle);
part_type_destroy(particle2); particle = -1; particle2 = -1;
ds_list_destroy(combatantsHit); combatantsHit = -1;
audio_emitter_free(soundEmitter); soundEmitter = -1;

if isSpell || isSoundLooping {
	audio_stop_sound(sound);
}