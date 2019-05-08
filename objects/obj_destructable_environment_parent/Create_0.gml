/// @description Insert description here
// You can write your code in this editor

event_inherited();

particles = []; // array of part types for destruction
system = part_system_create();
emitter = part_emitter_create(system);

destructionSound = noone;

stopsAttacks = false;

hasSetAlarm = false;