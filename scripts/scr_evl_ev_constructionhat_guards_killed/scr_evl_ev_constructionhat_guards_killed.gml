/// scr_evl_ev_constructionhat_guards_killed(arr)
/// @param arr

var arr = argument[0];
var victim = arr[0];

if variable_instance_exists(victim, "enemyKey") && arrayIncludes(enemyKeys, victim.enemyKey) {
	// check if this was the last unfairy guard to be killed, if so, we done
	var isAtLeastOneAlive = false;
	with obj_enemy_unfairy {
		if variable_instance_exists(id, "enemyKey") && arrayIncludes(other.enemyKeys, enemyKey) && hp > 0 {
			isAtLeastOneAlive = true;
		}
	}
	
	// if all guards killed, step is done
	if !isAtLeastOneAlive {
		status = EventStepStatus.Completed;
	}
}