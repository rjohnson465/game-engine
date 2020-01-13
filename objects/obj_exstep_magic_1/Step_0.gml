if status != ExerciseStepStatus.InProgress exit;

if inventoryContainsItem(obj_hand_item_wand) {
	status = ExerciseStepStatus.Completed;
}

// create a wand item drop, if player does not have one yet
if status != ExerciseStepStatus.Completed && !inventoryContainsItem(obj_hand_item_wand) && !hasMadeWand {
	var wand = instance_create_layer(x, y, global.player.layer, obj_hand_item_wand);
	var list = ds_list_create(); ds_list_add(list, wand);
	makeItemDrop(list, 3820, 2210, global.player.layer);
	
	with exercise {
		// make an enemy blocker, so enemy can't get to player
		enemyBlocker = instance_create_layer(2550, 2160, global.player.layer, obj_log);
		enemyBlocker.image_xscale = 10;
		enemyBlocker.visible = false; 
		enemyBlocker2 = instance_create_layer(3520, 1980, global.player.layer, obj_log);
		enemyBlocker2.image_xscale = 10;
		enemyBlocker2.visible = false;
		global.isPopulatingGrids = true;
	}
	
	hasMadeWand = true;
}
