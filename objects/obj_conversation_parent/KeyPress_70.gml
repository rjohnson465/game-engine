if !canBeSkipped exit;

if audio_is_playing(currentSound) {
	audio_stop_sound(currentSound);
	canBeSkipped = false;
	alarm[0] = CONV_SKIP_DELAY_FRAMES;
}