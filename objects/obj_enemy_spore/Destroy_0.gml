/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part_type_destroy(sporeParticle); sporeParticle = -1;
part_emitter_destroy(sporeSystem, sporeEmitter); sporeEmitter = -1;
part_system_destroy(sporeSystem); sporeSystem = -1;