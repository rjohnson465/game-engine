// re-spawn all enemies in all maps

with obj_enemy_data {
	currentX = postX;
	currentY = postY;
	hp = maxHp;
	isAlive = true;
}

with obj_enemy_parent {
	event_perform(ev_other,ev_room_start);
}

/*
with obj_room_data {
	for (var i = 0; i < ds_list_size(enemiesData); i++) {
		var enemyData = ds_list_find_value(enemiesData,i);
		enemyData.currentX = enemyData.postX;
		enemyData.currentY = enemyData.postY;
		enemyData.hp = enemyData.maxHp;
		enemyData.isAlive = true;
				
		// actually reposition / heal enemies in this room
		if roomIndex == room {
			var enemy = findPersistentRoomElement(obj_enemy_parent,enemyData.postX,enemyData.postY);
			with enemy {
				path_end();
			}
			enemy.x = enemyData.postX;
			enemy.y = enemyData.postY;
			enemy.layer = enemyData.postZ;
			enemy.hp = enemyData.maxHp;
			enemy.isAlive = true;
			enemy.isDying = false;
			ds_map_clear(enemy.preparingLimbs);
			ds_map_clear(enemy.attackingLimbs);
			ds_map_clear(enemy.recoveringLimbs);
			enemy.state = CombatantStates.Idle;
			enemy.lockOnTarget = noone;
			enemy.showHp = false;
			enemy.isShowingLightRadius = true;
				
			// cure any and all conditions
			var currentCondition = ds_map_find_first(enemy.conditionPercentages);
			for (var j = 0; j < ds_map_size(enemy.conditionPercentages);j++) {
				ds_map_replace(enemy.conditionPercentages,currentCondition,0);
				currentCondition = ds_map_find_next(enemy.conditionPercentages, currentCondition);
			}
		}
	}
}