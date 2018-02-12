/// wishAtFountain()
// static function
	
var fountain = id;

// activate fountain
if !isRunning {
	isRunning = true;
	sprite_index = asset_get_index("spr_fountain_filling");		
	with obj_player {
		lastFountainRoom = room;
		lastFountainX = fountain.x+100;
		lastFountainY = fountain.y+100;
	}
}
	
// wish at fountain
else {
		
	// show water particles from "wish"
	randomize();
	var x1 = x + random_range(-15,15);
	var y1 = y + random_range(-15,15);

	part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
	part_emitter_burst(system,emitter,particle,num);
		
	// re-spawn all enemies in all maps
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
				enemy.x = enemyData.postX;
				enemy.y = enemyData.postY;
				enemy.hp = enemyData.maxHp;
				enemy.isAlive = true;
				enemy.isDying = false;
				enemy.state = CombatantStates.Idle;
				enemy.showHp = false;
				enemy.preparingLimbs = ds_map_create();
				enemy.attackingLimbs = ds_map_create();
				enemy.recoveringLimbs = ds_map_create();
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
		
	// refill player health and stamina
	with obj_player {
		hp = maxHp;
		stamina = maxStamina;
	}
}