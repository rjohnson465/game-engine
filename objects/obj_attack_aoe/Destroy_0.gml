part_emitter_destroy(system,emitter);
part_system_destroy(system); system = -1; emitter = -1;

ds_list_destroy(combatantsHit); combatantsHit = -1;
audio_emitter_free(soundEmitter); soundEmitter = -1;

ds_map_destroy(additionalDamages); additionalDamages = -1;