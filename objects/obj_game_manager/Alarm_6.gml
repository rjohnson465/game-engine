// don't assess roomStartScript if still have to respawn enemies
if global.respawnEnemiesAfterGridsPopulate {
	alarm[6] = 1;
}

with all {
	if variable_instance_exists(id, "roomStartScript") && script_exists(roomStartScript) {
		script_execute(roomStartScript);
	}
}