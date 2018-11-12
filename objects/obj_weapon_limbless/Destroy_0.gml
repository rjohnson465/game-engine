part_emitter_destroy(system, emitter); emitter = -1;
part_emitter_destroy(torchSystem1, torchEmitter1); torchEmitter1 = -1;
part_emitter_destroy(torchSystem2, torchEmitter2); torchEmitter2 = -1;
part_system_destroy(system); system = -1;

/*for (var i = 0; i < array_length_1d(weaponParticles); i++) {
	var part = weaponParticles[i];
	if part != noone && part_type_exists(part) {
		part_type_destroy(part); part = noone;
	}
}*/

/*
if part_type_exists(torchParticle1) {
	part_type_destroy(torchParticle1); torchParticle1 = -1;
}
if part_type_exists(torchParticle2) {
	part_type_destroy(torchParticle2); torchParticle2 = -1;
}
audio_emitter_free(torchAudioEmitter); torchAudioEmitter = -1;