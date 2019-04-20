if global.player.hp <= 0 exit;

audio_play_sound(snd_ui_option_change, 1, 0);

if global.player.leftHandItem.chargesMax != 0 || global.player.rightHandItem.chargesMax != 0 {
	// switch attunement
	if global.player.currentSpellPrepSound != noone {
		audio_stop_sound(global.player.currentSpellPrepSound);
	}
	global.player.currentSpellAttunement = spellAttunementString;
}