if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
}
if part_system_exists(torchSystem1) && part_emitter_exists(torchSystem1, torchEmitter1) {
	part_emitter_destroy(torchSystem1, torchEmitter1); torchEmitter1 = -1;
}
if part_system_exists(torchSystem2) && part_emitter_exists(torchSystem2, torchEmitter2) {
	part_emitter_destroy(torchSystem2, torchEmitter2); torchEmitter2 = -1;
}

if part_system_exists(system) {
	part_system_destroy(system); system = -1;
}

if part_system_exists(torchSystem1) {
	part_system_destroy(torchSystem1); torchSystem1 = -1;
}

if part_system_exists(torchSystem2) {
	part_system_destroy(torchSystem2); torchSystem2 = -1;
}

if part_type_exists(torchParticle1) {
	part_type_destroy(torchParticle1); torchParticle1 = -1;
}
if part_type_exists(torchParticle2) {
	part_type_destroy(torchParticle2); torchParticle2 = -1;
}
if audio_emitter_exists(torchAudioEmitter) {
	audio_emitter_free(torchAudioEmitter); torchAudioEmitter = -1;
}
audio_stop_sound(torchSoundId); torchSoundId = -1;