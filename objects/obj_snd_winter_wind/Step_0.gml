/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if layer != global.player.layer {
	audio_emitter_gain(emitter, 0);
} else {
	audio_emitter_gain(emitter, gain);
}