part_emitter_destroy(system,emitter);
part_system_destroy(system);
part_type_destroy(particle);
part_type_destroy(particle2);
ds_list_destroy(combatantsHit);
audio_emitter_free(soundEmitter);

if isSpell || isSoundLooping {
	audio_stop_sound(sound);
}