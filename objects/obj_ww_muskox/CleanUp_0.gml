/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if part_system_exists(system) {
	if part_emitter_exists(system, emitter) {
		part_emitter_destroy(system, emitter); emitter = -1;
	}
	
	part_system_destroy(system); system = -1;
}

if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}