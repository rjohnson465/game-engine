endX = prevX; endY = prevY;
prevX = x;
prevY = y;

// maybe reset the old free grid space
if gridTempFreeX != noone {
	// make sure this combatant is no longer in this cell
	// these are the "grid coordinates" of this combatant
	var gridX = x div cell_width;
	var gridY = y div cell_height;
	// gridX must be between range (gridTempFreeX, gridTempFreeX + cell_width)
	var gridTempFreeX2 = gridTempFreeX + cell_width;
	var isInXRange = gridX >= gridTempFreeX && gridX <= gridTempFreeX2;
	// gridY must be between range (gridTempFreeX, gridTempFreeY + cell_height)
	var gridTempFreeY2 = gridTempFreeY + cell_height;
	var isInYRange = gridY >= gridTempFreeY && gridY <= gridTempFreeY2;
	// if the combatant is no longer in either of the proper ranges, repopulate the grid
	if (!isInXRange || !isInYRange) {
		//populatePersonalGrid();
		
		
		// TODO -- maybe make sure there are no enemies in this grid cell at all before marking it as blocked
		// populateGrids();
		global.isPopulatingGrids = true;
		
		// reset gridTempFree values so this check doesn't happen every step
		gridTempFreeX = noone;
		gridTempFreeY = noone;
	}
}

if state != CombatantStates.Attacking attackData = noone;
if type == CombatantTypes.Player exit;
// death
if hp < 1 && isAlive && !isDying {
	
	if type == CombatantTypes.Enemy {
		raiseEvent(EV_ENEMY_KILLED, [id]);
	}
	
	if array_length_1d(soundsWhenDie) > 0 {
		// pick a death sound
		randomize();
		
		var rand = round(random_range(0,array_length_1d(soundsWhenDie)-1));
		var deathSnd = soundsWhenDie[rand];
		audio_play_sound_at(deathSnd,x,y,depth,250,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
	
	audio_emitter_gain(walkingEmitter,0);
	audio_emitter_gain(walkingInWaterEmitter,0);
	audio_stop_sound(walkingSoundIndex); walkingSoundIndex = noone;
	audio_stop_sound(walkingInWaterSoundId); walkingInWaterSoundId = noone;
	
	isDying = true;
	lockOnTarget = noone;
	deathFrameFlag = true;
	alarm[8] = 2; // for death flag;
	
	hp = 0;
	audio_stop_sound(walkingSoundIndex);
	walkingSoundIndex = noone;
	audio_emitter_gain(walkingEmitter,0);
	
	speed = 0;
	ds_map_clear(preparingLimbs);
	ds_map_clear(attackingLimbs);
	ds_map_clear(recoveringLimbs);
	if fallFrame == fallTotalFrames {
		// create death particles
		global.owner = id;
		randomize();
		var rand = random_range(0,100);
		if ds_map_find_value(conditionPercentages,ICE) > 33 && (rand > 0) {
			global.condition = "IceDeath";
			dyingFrame = dyingTotalFrames;
			audio_play_sound_at(snd_iceshatter,x,y,depth,200,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		} else {
			audio_play_sound_at(snd_death_fade,x,y,depth,500,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			
			global.condition = "Death";
		}
		instance_create_depth(x,y,1,obj_condition_particles);
	} else fallScaleFactor = 0;
	
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		ds_map_replace(conditionLevels,currentCondition,0);
		var emitter = ds_map_find_value(conditionsEmittersMap, currentCondition);
		audio_emitter_gain(emitter,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	endureConditions(); drainConditions();
	
	if (isBoss && !isBossKilledBefore) || !isBoss {
		var xpAmount = round(xpReward*(global.player.xpMultiplier/100));
		gainXp(xpAmount);
	}
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
		if type == CombatantTypes.Enemy && fallFrame == fallTotalFrames {
			
			if ds_list_size(droppedItemsMandatory) != 0 {
				for (var k = 0; k < ds_list_size(droppedItemsMandatory); k++) {
					var dim = ds_list_find_value(droppedItemsMandatory, k);
					dim.isMandatory = true;
					// make sure this is the only copy of the mandatory item in game accessible to player
					var doNotAddToDroppedItems = false;
					with obj_item_drop {
						for (var m = 0; m < ds_list_size(items); m++) {
							var mim = ds_list_find_value(items, m);
							if instance_exists(mim) && instance_exists(dim) {
								if mim.name == dim.name && mim.id != dim.id {
									doNotAddToDroppedItems = true;
								}
							}
						}
					}
					// only drop the mandatory item if the player does not already have it
					var alreadyHasItem = false;
					if !doNotAddToDroppedItems {
						for (var l = 0; l < ds_list_size(global.player.inventory); l++) {
							var invItem = ds_list_find_value(global.player.inventory, l); 
							var iname = invItem.name;
							if (iname == dim.name) {
								alreadyHasItem = true;
							}
						}
					}
					if !alreadyHasItem && !doNotAddToDroppedItems {
						ds_list_add(droppedItems, dim);
					}
					
				}
			}
			
			// maybe just replace all items with some list
			if droppedItemsReplacement > 0 {
				ds_list_clear(droppedItems);
				for (var k = 0; k < ds_list_size(droppedItemsReplacement); k++) {
					var di = ds_list_find_value(droppedItemsReplacement, k);
					ds_list_add(droppedItems, di);
				}
			}
			
			if ds_list_size(droppedItems) > 0 {
				
				// delete any 0 gold objects
				var size = ds_list_size(droppedItems);
				var j = 0;
				for (var i = 0; i < size; i++) {
					var it = ds_list_find_value(droppedItems,j);
					if it == noone || it == undefined || !instance_exists(it) {
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
		updatePersistentElementProperty(id,"Hp",0);
		updatePersistentElementProperty(id,"IsAlive",false);
		maybeMakeHealthOrb();
		
		if isBoss {
			isBossKilledBefore = true;
			updatePersistentElementProperty(id, "IsBossKilledBefore", true);
		}
	}
}

if !isAlive {
	
	speed = 0;
	if type == CombatantTypes.Enemy {
		
		showHp = false;
		isShowingLightRadius = false;
		lightRadiusColor = c_white;
				
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
