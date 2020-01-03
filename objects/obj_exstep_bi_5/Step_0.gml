if status != ExerciseStepStatus.InProgress exit;

if !hasInitializedEnemy {
	var lay = global.player.layer;
	var unfairy = instance_create_layer(1525, 1886, lay, obj_enemy_unfairy);
	with unfairy {
		ei_unfairy_unarmed();
		droppedItemsReplacement = ds_list_create();
		chanceToDropHealthOrb = 1;
	}
	
	exercise.enemy = unfairy;
	hasInitializedEnemy = true;
}

if instance_exists(exercise.enemy) && exercise.enemy.hp <= 0 {
	status = ExerciseStepStatus.Completed;
}


