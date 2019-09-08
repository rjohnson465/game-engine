/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isBurrowing && isMoving {
	sprite_index = -1;
	part_emitter_region(sprintParticleSystem, sprintParticleEmitter, x-10, x+10, y-10, y+10, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(sprintParticleSystem, sprintParticleEmitter, burrowParticle, 10);
} else {
	sprite_index = normalSpriteIndex;
}