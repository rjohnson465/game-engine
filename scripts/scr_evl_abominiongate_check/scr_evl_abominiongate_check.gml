/// scr_abominiongate_check(arr)
/// @param arr

var arr = argument[0];
var victim = arr[0];

if victim.object_index == obj_enemy_abominion && variable_instance_exists(victim, "eventKey") && arrayIncludes(eventKeys, victim.eventKey) {
	enemiesLeft--;
}

if enemiesLeft == 0 {
	isUntraversable = false;
}
