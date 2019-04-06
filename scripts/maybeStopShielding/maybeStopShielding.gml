/// maybeStopShielding()
/// if combatant is shielding and they've reached the end of their shielding frames, stop shielding
/// method must be called by a combatant

if isShielding {
	if shieldingFrame >= totalShieldingFrames {
		isShielding = false;
		shieldingFrame = 0;
		hasCalculatedWillShield = false;
	}
	else shieldingFrame++;
}