/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if part_system_exists(summonPartSystem) {

	if part_emitter_exists(summonPartSystem, summonPartEmitter) {
		part_emitter_destroy(summonPartSystem, summonPartEmitter); summonPartEmitter = -1;
	}
	
	part_system_destroy(summonPartSystem); summonPartSystem = -1;

}

if part_type_exists(summonParticle1) {
	part_type_destroy(summonParticle1); summonParticle1 = -1;
}

if part_type_exists(summonParticle2) {
	part_type_destroy(summonParticle2); summonParticle2 = -1;
}