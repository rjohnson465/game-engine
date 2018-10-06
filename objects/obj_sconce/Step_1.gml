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
			isLit = true;
			audio_emitter_gain(soundEmitter,MAXGAIN);
			updatePersistentElementProperty(id, "isLit", true);
			audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			global.owner = id;
			global.makeLightOnCreate = true;
			lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
			with lightRadius {
				var floorNum = getLayerFloorNumber(other.origLayer);
				light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
			}
		}
	}
}