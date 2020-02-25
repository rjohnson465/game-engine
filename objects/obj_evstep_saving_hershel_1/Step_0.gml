if status != EventStepStatus.InProgress exit;

// This step is marked as done when the player's lock on target is a valid enemy
var hershel = instance_nearest(x, y, obj_hershel);

if hershel.hp <= 0 {
	scr_event_fail(event);
}

if ds_list_size(ghostsSpawnedList) == GHOSTS_TO_SPAWN_COUNT {
	
	var isAtLeastOneAlive = false;
	// if all ghosts this step spawned were killed, this step is done
	for (var i = 0; i < ds_list_size(ghostsSpawnedList); i++) {
		var g = ds_list_find_value(ghostsSpawnedList, i);
		if g.hp >= 1 {
			isAtLeastOneAlive = true;
		}
	}
	
	if !isAtLeastOneAlive {
		status = EventStepStatus.Completed;
		
		hershel.isGoingToAri = true;
	}
	
}