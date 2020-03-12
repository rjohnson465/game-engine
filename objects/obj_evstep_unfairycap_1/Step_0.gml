if status != EventStepStatus.InProgress exit;

with obj_enemy_icetroll {
	if variable_instance_exists(id, "enemyKey") && enemyKey == "cap" && hp <= 0 {
		other.status = EventStepStatus.Completed;
	}
}