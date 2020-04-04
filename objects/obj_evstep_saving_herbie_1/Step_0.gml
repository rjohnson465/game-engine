if status != EventStepStatus.InProgress exit;

// if there is an enemy that can path to player within 300px of herbie, herbie stops walking

var herbieSpeed = 4;

var evstep = id;
with herbie {
	isInteractable = false;
	isInteractingWithPlayer = false;
	global.isInteractingWithNpc = false;
	
	switch state {
		case CombatantStates.Idle: {
			path_end();
			speed = 0;
			
			// wait in idle for a while?
			if other.idleFrame < 30 {
				other.idleFrame++;
				break;
			}
			
			// if there is at least one enemy that can path to player and is 300px or less from herbie do nothing
			var doPanic = false;
			with obj_enemy_parent {
				if lockOnTarget == global.player {
					var pathExists = mp_grid_path(personalGrid, gridPath, x, y, lockOnTarget.x, lockOnTarget.y, true);
					if pathExists {
						if distance_to_object(other) < 300 {
							doPanic = true;
							evstep.message = evstep.DESC_FIGHT;
						}
					}
				}
			}
			
			if doPanic break;
			else if evstep.message == evstep.DESC_FIGHT {
				evstep.message = evstep.DESC_ESCORT;	
			}
			
			if other.justReachedPathObjective || other.pathObjectiveIndex == -1 {
				other.pathObjectiveIndex++;
				if other.justReachedPathObjective {
					other.justReachedPathObjective = false;
				}
			}

			state = CombatantStates.Moving;
			
			break;
		}
		case CombatantStates.Moving: {
			
			other.justReachedPathObjective = false;
			facingDirection = direction;
			other.idleFrame = 0;
			
			// if too far from player, switch to idle
			if distance_to_object(obj_player) > 300 {
				state = CombatantStates.Idle;
				other.message = other.DESC_LONELY;
				break;
			} else if other.message == other.DESC_LONELY {
				other.message = other.DESC_ESCORT;
			}
			
			// if enemy nearby that can path to player too close to herbie, stop
			var doPanic = false;
			with obj_enemy_parent {
				if lockOnTarget == global.player {
					var pathExists = mp_grid_path(personalGrid, gridPath, x, y, lockOnTarget.x, lockOnTarget.y, true);
					if pathExists {
						if distance_to_object(other) < 300 {
							doPanic = true;
							evstep.message = evstep.DESC_FIGHT;
						}
					}
				}
			}
			
			if doPanic {
				state = CombatantStates.Idle;
				break;
			}
			else if evstep.message == evstep.DESC_FIGHT {
				evstep.message = evstep.DESC_ESCORT;	
			}
			
			// if arrived at current path end, go to Idle
			var pathObjective = ds_list_find_value(other.pathObjects, other.pathObjectiveIndex);
			if pathObjective == undefined || !instance_exists(pathObjective) {
				state = CombatantStates.Idle;
				break;
			}
			
			if distance_to_object(pathObjective) < 15 {
				// if it was a tree, knock it down
				if pathObjective.object_index == obj_stump_frozen {
				
					with pathObjective {
						
						isFallen = true;
						removeFromInteractablesList();
						updatePersistentElementProperty(id,"isFallen",true);
						sprite_index = spr_stump_frozen_falling;
						audio_play_sound_at(fallingSound,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
						light_destroy_caster_layer(getLayerFloorNumber(origLayer));
		
			
						global.damageType = ICE;
						global.x1 = x;
						global.y1 = y;
						global.particleDirection = 0;
						global.hitParticlesLayer = origLayer;
						global.victim = noone;
						instance_create_depth(x,y,1,obj_hit_particles);
						
					}
				
				}
				
				// if it is mrs claus, we are done with this event step
				if pathObjective.object_index == obj_npc_mrsclaus {
					other.status = EventStepStatus.Completed;
					isInteractable = true;
					path_end();
					break;
				}
				
				other.justReachedPathObjective = true;
				path_end();
				state = CombatantStates.Idle;
				break;
			}
			
			// path to objective
			var pe = mp_grid_path(personalGrid, gridPath, x, y, pathObjective.x, pathObjective.y, true);
			if pe {
				path_start(gridPath, herbieSpeed, path_action_stop, false);
			} else {
				state = CombatantStates.Idle;
			}
			
			break;
			
		}
	}
	
}
