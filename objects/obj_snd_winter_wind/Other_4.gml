if layer != global.player.layer {
	audio_emitter_gain(emitter, 0);
} else {
	audio_emitter_gain(emitter, gain);
}