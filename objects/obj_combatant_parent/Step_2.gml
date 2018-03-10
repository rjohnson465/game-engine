with obj_attack {
	if place_meeting_layer(x,y,other.id) {
		with other {
			calculateDamage();
		}
	}
}

