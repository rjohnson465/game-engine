if type == CombatantTypes.Player exit;
// death
if hp < 1 && isAlive && !isDying {
	isDying = true;
	lockOnTarget = noone;
	
	hp = 0;
	fallFrame = fallTotalFrames;
	fallScaleFactor = 1;
	speed = 0;
	ds_map_clear(preparingLimbs);
	ds_map_clear(attackingLimbs);
	ds_map_clear(recoveringLimbs);
	// create death particles
	global.owner = id;
	randomize();
	var rand = random_range(0,100);
	if ds_map_find_value(conditionPercentages,ICE) > 33 && (rand > 0) {
		global.condition = "IceDeath";
		dyingFrame = dyingTotalFrames;
		audio_play_sound_at(snd_iceshatter,x,y,depth,20,200,1,0,1);
	} else {
		global.condition = "Death";
	}
	instance_create_depth(x,y,1,obj_condition_particles);
	
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	
	var xpAmount = round(xpReward*(global.player.xpMultiplier/100));
	gainXp(xpAmount);
	//global.xpAmount = round(xpReward*(global.player.xpMultiplier/100));
	//instance_create_depth(x,y,1,obj_xp);
}

if isDying && isAlive {
	if dyingFrame < dyingTotalFrames {
		speed = 0;
		dyingFrame++;
		
		if global.player.lockOnTarget == id {
			// find nearest enemy to player that player can lock on to
			var enemiesNearby = scr_collision_circle_list_layer(x,y,500,obj_enemy_parent,0,1);
			var nearbyEnemiesCount = ds_list_size(enemiesNearby);
			for (var i = 0; i < ds_list_size(enemiesNearby); i++) { 
				var enemy = noone;
				var j = 0;
				do {
					j++;
					enemy = scr_find_nth_closest(x,y,obj_enemy_parent,i);
				} until enemy.layer == global.player.layer || j > nearbyEnemiesCount;
				global.player.lockOnTarget = enemy;
				with global.player {
					if canSeeLockOnTarget() break;
				}
			}
			if ds_exists(enemiesNearby,ds_type_list) {
				ds_list_destroy(enemiesNearby); enemiesNearby = -1;
			}
		}
		
	} else {
		dyingFrame = 0;
		state = CombatantStates.Idle;
		if type == CombatantTypes.Enemy {
			
			if ds_list_size(droppedItems) > 0 {
				
				// delete any 0 gold objects
				var size = ds_list_size(droppedItems);
				var j = 0;
				for (var i = 0; i < size; i++) {
					var it = ds_list_find_value(droppedItems,j);
					if it == noone || it == undefined {
						ds_list_delete(droppedItems,j);
						j--;
					}
					else if it.object_index == obj_item_coins && it.count == 0 {
						ds_list_delete(droppedItems,j);
						instance_destroy(it,1);
						j--;
					}
					j++;
				}
				
				if ds_list_size(droppedItems) > 0 {
					var drop = makeItemDrop(droppedItems);
					drop.x = x;
					drop.y = y;
				}
				//ds_list_clear(droppedItems);
			}
		}
		isAlive = false;
		isDying = false;
		//global.player.xpTemp += round((xpReward*(global.player.xpMultiplier/100)));
	}
}

if !isAlive {
	
	speed = 0;
	if type == CombatantTypes.Enemy {
		
		showHp = false;
		isShowingLightRadius = false;
		lightRadiusColor = c_white;
				
		enemyData.hp = 0;
		enemyData.isAlive = false;
				
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				x = -1000;
				y = -1000;
			}
		}
	}
	x = -1000;
	y = -1000;
	
}
