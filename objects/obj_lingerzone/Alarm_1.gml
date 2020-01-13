// damage every alarm[1] frames
with obj_player {
	if other.layer != layer || distance_to_object(other) > 32 {
		continue;
	}
	if place_meeting_layer(x,y,other) {
		damageCombatant(other.lingerZoneDamages,0,0,id,other);
	}
}
alarm[1] = lingerZoneDamageFrequency;