if global.player.hp <= 0 exit;
if global.player.leftHandItem.chargesMax != 0 || global.player.rightHandItem.chargesMax != 0 {
	// switch attunement
	global.player.currentSpellAttunement = spellAttunementString;
}