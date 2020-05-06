/// scr_abominiongate_roomstart

instance_activate_object(obj_enemy_abominion);

with obj_enemy_abominion {
	event_perform(ev_room_start, 0);
	if variable_instance_exists(id, "eventKey") && arrayIncludes(other.eventKeys, eventKey) && hp <= 0 {
		other.enemiesLeft--;
	}
}

if enemiesLeft == 0 {
	isUntraversable = false;
}
