part_emitter_destroy(system,emitter);
part_system_destroy(system);
part_type_destroy(particle);

if isRunning {
	audio_stop_sound(snd_fountain_running);
}