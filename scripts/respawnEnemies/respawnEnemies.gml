// re-spawn all enemies in all maps
// TODO - do not respawn bosses? MAYBE?

with obj_enemy_data {
	instance_destroy(id,1);
}

with obj_enemy_parent {
	x = postX;
	y = postY;
	layer = postZ;
	hp = maxHp;
	isAlive = true;
	event_perform(ev_other,ev_room_start);
}
