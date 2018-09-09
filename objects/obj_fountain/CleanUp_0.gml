part_emitter_destroy(system,emitter); emitter = -1;
part_system_destroy(system); system = -1;
part_type_destroy(particle); particle = -1;
audio_emitter_free(fountainRunningSoundEmitter); fountainRunningSoundEmitter = -1;


/*
if isRunning {
	audio_stop_sound(snd_fountain_running);
}

