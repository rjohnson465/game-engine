// re-spawn all enemies in all maps
// TODO - do not respawn bosses? MAYBE?

with obj_enemy_data {
	instance_destroy(id,1);
}

with obj_enemy_parent {
	x = postX;
	y = postY;
	layer = postZ;
	facingDirection = postDir;
	hp = maxHp;
	fallFrame = fallTotalFrames;
	fallScaleFactor = 1;
	isAlive = true;
	onAlert = false;
	state = CombatantStates.Idle;
	lockOnTarget = noone;
	event_perform(ev_other,ev_room_start);
}
