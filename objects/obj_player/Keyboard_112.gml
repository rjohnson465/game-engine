if room == game_menu {
	exit;
}
if currentSpellPrepSound != noone {
	audio_stop_sound(currentSpellPrepSound);
}
currentSpellAttunement = MAGIC;