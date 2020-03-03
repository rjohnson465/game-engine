if status != EventStepStatus.InProgress exit;

var isAtLeastOneAlive = false;
with obj_enemy_dybukk {
	if hp > 0 && variable_instance_exists(id, "enemyKey") && arrayIncludes(other.enemyKeys, enemyKey) {
		isAtLeastOneAlive = true;
	}
}

if !isAtLeastOneAlive {
	status = EventStepStatus.Completed;
}