/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if part_type_exists(sporeParticle) {
	part_type_destroy(sporeParticle); sporeParticle = -1;
}

if part_type_exists(possessParticle) {
	part_type_destroy(possessParticle); possessParticle = -1;
}

if part_system_exists(sporeSystem) && part_emitter_exists(sporeSystem, sporeEmitter) {
	part_emitter_destroy(sporeSystem, sporeEmitter); sporeEmitter = -1;
}
if part_system_exists(sporeSystem) {
	part_system_destroy(sporeSystem); sporeSystem = -1;
}

if instance_exists(beamLight) {
	instance_destroy(beamLight); beamLight = -1;
}