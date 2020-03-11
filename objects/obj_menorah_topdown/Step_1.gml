if isLit {
	if origLayer != global.player.layer {
		audio_emitter_gain(soundEmitter,0);
	} else {
		audio_emitter_gain(soundEmitter,MAXGAIN);
	}
}


if isLit exit;
