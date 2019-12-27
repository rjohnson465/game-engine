if status != ExerciseStepStatus.InProgress exit;

if status == ExerciseStepStatus.InProgress && ds_map_size(eventListeners) == 0 {
	ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_exstep_mc2);
}

if hitsReceived >= 3 {
	status = ExerciseStepStatus.Completed;
}

if status == ExerciseStepStatus.Completed {
	if ds_exists(eventListeners, ds_type_map) {
		ds_map_destroy(eventListeners); eventListeners = -1;
	}
	exit;	
}

// do not allow the enemy to be killed during this step 
if exercise.enemy {
	with exercise.enemy {
		hp = 1000;
		maxHp = 1000;
	}
}
