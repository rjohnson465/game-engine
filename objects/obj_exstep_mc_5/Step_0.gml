if status != ExerciseStepStatus.InProgress exit;

if inventoryContainsItem(obj_hand_item_woodshield) {
	status = ExerciseStepStatus.Completed;
}
exercise.enemy.x = 2000;
	exercise.enemy.y = 2000;
if !hasDisabledEnemy {
	// instance_deactivate_object(exercise.enemy);
	
	hasDisabledEnemy = true;
	
	// create shield drop (only if player does not have a shield)
	if !inventoryContainsItem(obj_hand_item_woodshield) {
		var list = ds_list_create();
		ds_list_add(list, instance_create_depth(x,y,1,obj_hand_item_woodshield));
		makeItemDrop(list, 1314, 193, global.player.layer);
	}
}

