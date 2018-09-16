if place_meeting(x,y,obj_player) {
	jumpToNearestFreePoint(1);
}

if isFloating {
	audio_play_sound_on(walkingInWaterEmitter,snd_water_floating_loop,1,0);
}

// initiated here so dyingParticle exist
sprintParticle = part_type_create();
part_type_sprite(sprintParticle,sprite_index,1,0,1);
part_type_alpha2(sprintParticle,.75,.25);
part_type_color2(sprintParticle,dyingParticleColor1,dyingParticleColor2);
part_type_life(sprintParticle,4,8);
sprintParticleSystem = part_system_create();
sprintParticleEmitter = part_emitter_create(sprintParticleSystem);