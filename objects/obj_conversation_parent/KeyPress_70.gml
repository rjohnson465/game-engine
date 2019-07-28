if !canBeSkipped exit;

if audio_is_playing(currentSound) {
	audio_stop_sound(currentSound);
}