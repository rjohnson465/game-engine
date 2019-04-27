if place_meeting(x,y,obj_player) {
	jumpToNearestFreePoint(1);
}

audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
walkingInWaterEmitter = audio_emitter_create();
audio_emitter_gain(walkingInWaterEmitter,0);
/*if isFloating {
	audio_play_sound_on(walkingInWaterEmitter,snd_water_floating_loop,1,0);
} else {
	audio_play_sound_on(walkingInWaterEmitter,snd_water_walking_loop,1,0);
}*/

// initiated here so dyingParticle exist
if part_type_exists(sprintParticle) {
	part_type_destroy(sprintParticle); sprintParticle = -1;
}
sprintParticle = part_type_create();
part_type_sprite(sprintParticle,sprite_index,1,0,1);
part_type_alpha2(sprintParticle,.75,.25);
var dp1 = dyingParticleColor1;
if is_array(dyingParticleColor1) {
	dp1 = dyingParticleColor1[0];
}
part_type_color2(sprintParticle,dp1,dyingParticleColor2);
part_type_life(sprintParticle,4,8);
if (part_system_exists(sprintParticleSystem) && part_emitter_exists(sprintParticleSystem, sprintParticleEmitter)) {
	part_emitter_destroy(sprintParticleSystem, sprintParticleEmitter); sprintParticleEmitter = -1;
	part_system_destroy(sprintParticleSystem); sprintParticleSystem = -1;
}
sprintParticleSystem = part_system_create();
sprintParticleEmitter = part_emitter_create(sprintParticleSystem);