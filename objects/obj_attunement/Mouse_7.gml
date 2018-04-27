if global.player.hp <= 0 exit;
if global.player.leftHandItem.totalCharges != 0 || global.player.rightHandItem.totalCharges != 0 {
	// switch attunement
	global.player.currentSpellAttunement = spellAttunementString;
}