part_emitter_destroy(system, emitter1); emitter1 = -1;
part_emitter_destroy(system, emitter2); emitter2 = -1;
part_system_destroy(system); system = -1;
part_type_destroy(particle1); particle1 = -1;
part_type_destroy(particle2); particle2 = -1;
part_type_destroy(particle3); particle3 = -1;
audio_emitter_free(soundEmitter); soundEmitter = -1;
audio_stop_sound(torchSoundId); torchSoundId = -1;

if instance_exists(lightRadius) {
	instance_destroy(lightRadius); lightRadius = -1;
}