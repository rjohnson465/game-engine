// ripple when turned on
if alarm[0] > 0 {
	var xx = abs(alarm[0]-30);
	var_radial_blur_offset = (-abs((xx-15)/30))+.5;
}

if isRunning {
	if origLayer != global.player.layer {
		audio_emitter_gain(fountainRunningSoundEmitter,0);
	} else {
		audio_emitter_gain(fountainRunningSoundEmitter,1);
	}
}