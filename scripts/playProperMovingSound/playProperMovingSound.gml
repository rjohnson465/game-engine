/// playProperMovingSound()

// if we're not moving at all, stop playing any walking sound
var nonMoveSoundStates = [
	CombatantStates.Attacking,
	CombatantStates.Idle,
	CombatantStates.Staggering,
	CombatantStates.Healing,
	CombatantStates.Dodging
];
if (!isMoving || arrayIncludes(nonMoveSoundStates, state)) && walkingSoundIndex {
	audio_stop_sound(walkingSoundIndex);
	walkingSoundIndex = -1;
}

// set the proper walking sound if moving (strafe / walk)
if type == CombatantTypes.Enemy && isMoving && !arrayIncludes(nonMoveSoundStates, state) {
	
	var strafeSoundName = "snd_enemy_" + spriteName + "_walk_strafe";
	var strafeSoundExists = asset_get_index(strafeSoundName) != -1;
	
	// if strafing / moving and we have a strafe sound, maybe play that if we're not already doing that
	if isStrafing && isMoving && strafeSoundExists {
		// check if we're already playing the strafe sound, if so, do nothing, if not, play strafe sound
		var currentWalkSoundName = audio_get_name(walkingSoundIndex);
		if currentWalkSoundName != strafeSoundName {
			// if we're playing the standard move sound, stop that
			if walkingSoundIndex >= 0 {
				audio_stop_sound(walkingSoundIndex);
				walkingSoundIndex = -1;
			}
			// now play the strafe sound on the walkingEmitter
			var strafeSound = asset_get_index(strafeSoundName);
			walkingSoundIndex = audio_play_sound_on(walkingEmitter, strafeSound, 1, 1);
		}
	}
	
	// check and make sure we're playing the standard move sound, if it exists
	if !isStrafing {
		var currentWalkSoundName = audio_get_name(walkingSoundIndex);
		// if we're playing the strafe sound, stop that
		if strafeSoundExists && currentWalkSoundName == strafeSoundName {
			audio_stop_sound(walkingSoundIndex);
			walkingSoundIndex = -1;
		}
		// otherwise, if we're not playing the walking sound and it exists, play that
		if walkingSound >= 0 && walkingSoundIndex <= 0 {
			walkingSoundIndex = audio_play_sound_on(walkingEmitter, walkingSound, 1, 1);
		}
	}
}