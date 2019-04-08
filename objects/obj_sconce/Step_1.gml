if isLit {
	if origLayer != global.player.layer {
		audio_emitter_gain(soundEmitter,0);
	} else {
		audio_emitter_gain(soundEmitter,MAXGAIN);
	}
}


if isLit exit;
with obj_attack {
	// lights on fire if hit with torch, a fire arrow, or a fire spell
	if place_meeting_layer(x,y, other) && ((weapon != noone && (weapon.object_index == obj_hand_item_torch || isOnFire)) || (isSpell && spellElement == FIRE)) {
		with other {
			lightSconce();
		}
	}
}