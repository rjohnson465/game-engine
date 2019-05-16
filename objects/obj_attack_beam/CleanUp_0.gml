/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if audio_emitter_exists(sndEmitter) {
	audio_stop_sound(sndEmitterSndId); sndEmitterSndId = -1;
	audio_emitter_free(sndEmitter); sndEmitter = -1;
}

if audio_emitter_exists(beamHitSoundEmitter) {
	audio_stop_sound(beamHitSoundLoop); beamHitSoundLoop = -1;
	audio_emitter_free(beamHitSoundEmitter); beamHitSoundEmitter = -1;
}