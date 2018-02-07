with obj_player {
	// drain comboMode levels
	if comboModeLevel > 0 {
		if comboModeFrame == 0 {
			comboModeLevel -= 1;
			comboModeFrame = comboModeTotalFrames;
		} else {
			comboModeFrame--;
		}
	}

	// time to start / continue combo
	if comboNumber > 0 || comboModeLevel > 0 {
		comboFrame++; // gets reset to 0 if an attack lands
	}

	if comboFrame >= comboTimeQuantum {
		comboNumber = 0;
		comboEffectiveNumber = 0;
	}

	// combo stuff
	if comboEffectiveNumber >= comboHitsToNextLevel {
		comboEffectiveNumber = 0;
		comboModeLevel += 1;
		comboModeFrame = comboModeTotalFrames;
	}
}