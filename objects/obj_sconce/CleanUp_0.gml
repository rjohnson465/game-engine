part_emitter_destroy(system, emitter); emitter = -1;
part_system_destroy(system); system = -1;
part_type_destroy(particle1); particle1 = -1;
part_type_destroy(particle2); particle2 = -1;
part_type_destroy(particle3); particle3 = -1;
audio_emitter_free(soundEmitter); soundEmitter = -1;
audio_stop_sound(torchSoundId); torchSoundId = -1;