if status != ExerciseStepStatus.InProgress exit;

if status == ExerciseStepStatus.InProgress && ds_map_size(eventListeners) == 0 {
	ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_exstep_mc8);
}

if blocksPerformed >= 3 {
	status = ExerciseStepStatus.Completed;
}

if !hasActivatedEnemy {
	exercise.enemy.x = exercise.enemy.postX;
	exercise.enemy.y = exercise.enemy.postY;
	hasActivatedEnemy = true;
}

// do not allow the enemy to be killed during this step 
if exercise.enemy {
	with exercise.enemy {
		hp = 1000;
		maxHp = 1000;
	}
}
