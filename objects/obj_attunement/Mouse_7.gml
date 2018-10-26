if global.player.hp <= 0 exit;
if global.player.leftHandItem.chargesMax != 0 || global.player.rightHandItem.chargesMax != 0 {
	// switch attunement
	if global.player.currentSpellPrepSound != noone {
		audio_stop_sound(global.player.currentSpellPrepSound);
	}
	global.player.currentSpellAttunement = spellAttunementString;
}