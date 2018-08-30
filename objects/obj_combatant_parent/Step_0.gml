if isFloating {
	functionalSpeed = normalSpeed*slowedSpeedModifier;
}
if scr_is_fading() {
	speed = 0;
	state = CombatantStates.Idle;
	path_end();
	exit;
}
if ((!isAlive && type != CombatantTypes.Player) || isDying) && state != CombatantStates.Staggering {
	path_end();
	speed = 0;
	exit;
}

if fallFrame < fallTotalFrames {
	fall();
	exit;
}

image_angle = facingDirection;
depth = layer_get_depth(layer);

// stamina / health regen
regenHealthAndStamina();

// conditionPercentages drain every step
drainConditions();

// account for any currently active conditions (slowed/frozen, burning, poisoned, electrified)
endureConditions();

// huge state machine
switch(state) {
	case CombatantStates.Idle: {
		
		// player overrides this
		if type != CombatantTypes.Player {
			speed = 0;
			
			var actingPostX = postX;
			var actingPostY = postY;
			if layer != postZ {
				actingPostX = tempPostX;
				actingPostY = tempPostY;
			}
			
			// if not on player layer and close to post, just stand still
			if layer != global.player.layer && distance_to_point(actingPostX,actingPostY) < 10 {
				lockOnTarget = noone;
				break;
			}
			
			// isNoticingEngagement -- if there is some ally you can see that has a lockOnTarget, try aggroing
			var allyType = object_is_ancestor(object_index,obj_enemy_parent) ? obj_enemy_parent : obj_goodguy_parent;
			var isNoticingEngagement = false;
			with allyType {
				var wallsBetweenAlly = scr_collision_line_list_layer(x,y,other.x,other.y,obj_wall_parent,true,true);
				if layer == other.layer && lockOnTarget != noone && wallsBetweenAlly == noone {
					// must be able to see this ally's engagement
					var dirToAlly = point_direction(other.x,other.y,x,y);
					if angleBetween(other.x-sightAngleDelta,other.y+sightAngleDelta,dirToAlly) {
						isNoticingEngagement = true;
					}
				}
				if wallsBetweenAlly != noone && ds_exists(wallsBetweenAlly, ds_type_list) {
					ds_list_destroy(wallsBetweenAlly); wallsBetweenAlly = -1;
				}
			}
			if	((canSeeLockOnTarget() || lockOnTarget != noone) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
				state = CombatantStates.AggroMelee;
				break;
			} else if canSeeLockOnTarget() && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
				state = CombatantStates.AggroRanged;
				break;
			}
			// just hit or sees a friend who is in trouble
			else if isNoticingEngagement || wasJustHit {
				wasJustHit = false;
				// first try ranged
				if array_length_1d(rangedAttacks) > 0 {
					state = CombatantStates.AggroRanged;
				} else state = CombatantStates.AggroMelee;
			}
			// else, check if we can hear any commotion (hit particles) 
			else if canHearNearbyHit() != noone {
				var hit = canHearNearbyHit();
				global.owner = id;
				var dir = (hit.particleDirection+180)%360;
				var x1 = hit.x1 + lengthdir_x(50,dir); var y1 = hit.y1 + lengthdir_y(50,dir);
				var target = instance_create_depth(x1,y1,1,obj_temp_lockontarget);
				lockOnTarget = target;
				state = CombatantStates.Moving;
				break;
			}
			// else, check if the player is just too goddamn close 
			else if distance_to_object(global.player) < 15 {
				state = CombatantStates.AggroMelee; break;
			}
			// if no aggro and not at postX/postY, head back there
			else if distance_to_point(postX, postY) > 10 && layer == postZ {
				state = CombatantStates.Moving;
				break;
			} else {
				showHp = false;
			}
			break;
		}
	}
	case CombatantStates.AggroMelee: {
		if type == CombatantTypes.Player break;
		chooseMeleeAttack();
		break;
	}
	case CombatantStates.AggroRanged: {
		if type == CombatantTypes.Player break;
		chooseRangedAttack();
		break;
	}
	case CombatantStates.Moving: {
		// player overrides this entirely
		if type != CombatantTypes.Player {
			
			// maybe return to post
			maybeReturnToPost();
			
			// if we've already chosen an attack during Idle state, we need to get close enough to target for that attack
			if currentMeleeAttack != noone || currentRangedAttack != noone {
				
				// face the proper direction
				faceMovingDirection();
				// CHECK 1: ARE WE OUT OF RANGE FOR THE CURRENTLY CHOSEN ATTACK?
				//if maybeChangeAttack() break;
				// CHECK 2: WILL WE DODGE IN THIS MOVE STATE?
				calculateWillDodge();
				if maybeDodge() break;
				// CHECK 3: WILL WE SHIELD IN THIS MOVE STATE?
				maybeShield();
				
				// CHECK 4: Maybe switch to melee / range
				if currentRangedAttack > -1 && distance_to_object(lockOnTarget) < meleeAggroRange {
					state = CombatantStates.AggroMelee; break;
				}
				else if currentMeleeAttack > -1 && distance_to_object(lockOnTarget) > meleeAggroRange {
					state = CombatantStates.AggroRanged; break;
				}
				
				// if we're not in range for attack, do this
				if maybeMoveNotInAttackRange() break;
				// within range for attack
				else {
					moveInAttackRange();
					break;
				}
			}
			// this means we're going to a temp lockOnTarget, probably investigating a sound
			else if lockOnTarget != noone {
				onAlert = true;
				// can aggro while investigating sound
				// check if in melee aggro range
				if	((canSeeLockOnTarget()) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
					lockOnTarget = noone;
					state = CombatantStates.AggroMelee;
					onAlert = false;
					break;
				} else
				// check if in ranged aggro range
				if canSeeLockOnTarget() && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
					lockOnTarget = noone;
					state = CombatantStates.AggroRanged;
					onAlert = false;
					break;
				}
				tempPostX = lockOnTarget.x; tempPostY = lockOnTarget.y;
				// pursue the source of the sound
				if instance_exists(lockOnTarget) && distance_to_object(lockOnTarget) > 25 {
					if mp_grid_path(personalGrid,path,x,y,lockOnTarget.x,lockOnTarget.y,0) {
						path_start(path,functionalSpeed,path_action_stop,false);
						turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
					} else {
						mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,functionalSpeed,14,0);
						path_start(path,functionalSpeed,path_action_stop,false);
						turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
					}
				} else {
					//instance_destroy(lockOnTarget,1);
					//lockOnTarget = noone;
					// look around before giving up
					if investigatingFrame <= investigatingFramesTotal {
						investigatingFrame++;
						
						//turnToFacePoint(turnSpeed, global.player.x, global.player.y);
						// wander around this point
						if alarm[6] == -1 alarm[6] = 30;
						if isInvestigating {
							moveToNearestFreePoint(investigatingDirection,functionalSpeed*.5,0);
							var x1 = x+lengthdir_x(5,investigatingDirection); var y1 = y+lengthdir_y(5,investigatingDirection);
							turnToFacePoint(turnSpeed,x1,y1);
						}

						
						if	((canSeeLockOnTarget()) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
							lockOnTarget = noone;
							state = CombatantStates.AggroMelee;
							onAlert = false;
							break;
						} else
						// check if in ranged aggro range
						if canSeeLockOnTarget() && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
							lockOnTarget = noone;
							state = CombatantStates.AggroRanged;
							onAlert = false;
							break;
						}
					} else {
					
						if lockOnTarget.object_index == obj_temp_lockontarget instance_destroy(lockOnTarget,1);
						investigatingFrame = 0;
						lockOnTarget = noone;
						state = CombatantStates.Idle;
						onAlert = false;
						break;
					}
				}
			}
			// if no attack is chosen and we have no lockOnTarget, we're probably heading back to post
			else {
				var actingPostX = postX;
				var actingPostY = postY;
				if layer != postZ {
					actingPostX = tempPostX;
					actingPostY = tempPostY;
				}
				if distance_to_point(actingPostX,actingPostY) > 2 {
					mp_grid_path(personalGrid,path,x,y,actingPostX,actingPostY,0);
					path_start(path,functionalSpeed,path_action_stop,false);
					var x1 = x+lengthdir_x(10,direction); var y1 = y+lengthdir_y(10,direction);
					turnToFacePoint(turnSpeed*2,x1,y1);
					
					// can aggro while returning to post 
					// check if in melee aggro range
					if	((canSeeLockOnTarget()) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
						state = CombatantStates.AggroMelee;
						break;
					} else
					// check if in ranged aggro range
					if canSeeLockOnTarget() && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
						state = CombatantStates.AggroRanged;
						break;
					}
				} else {
					state = CombatantStates.Idle;
				}
				break;
			}
		}
	}
	case CombatantStates.Attacking: {
		
		// THIS IS ONLY FOR ENEMY / ALLY
		// figure out what attack to perform / what number in chain
		if type != CombatantTypes.Player {
			
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			if attackNumber == noone break;
			var isRanged = currentRangedAttack != noone;
			
			// find attack data object
			var attackData = noone;
			var attackChain = isRanged ? rangedAttacks[attackNumber] : meleeAttacks[attackNumber];
			if attackNumberInChain == noone {
				attackData = attackChain[0];
			} else {
				attackData = attackChain[attackNumberInChain-1];
			}
			
			// get previous attacking limb
			if attackNumberInChain == noone && !isRanged && hasHands {
				var attackChain = meleeAttacks[attackNumber];
				var attackData = attackChain[0];
				var lk = attackData.limbKey;
				switch lk {
					case "e": {
						randomize();
						var rand = random_range(0,1);
						prevAttackLimb = rand - .5 > 0 ? "r" : "l";
						break;
					}
					default: {
						prevAttackLimb = lk;
						break;
					}
				}
			}
			
			// aim when preparing attack
			if ds_map_size(preparingLimbs) != 0 {
				turnToFacePoint(attackData.turnSpeed,lockOnTarget.x,lockOnTarget.y);
			}
			
			// it's posslbe we're out of range again, especially if the lockOnTarget staggered or ran. try getting in range again
			if !isRanged && ds_map_size(preparingLimbs) !=0 && attackData.type != AttackTypes.Charge {
				if distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack] && !place_meeting_layer(x,y,lockOnTarget) {
					mp_potential_step(lockOnTarget.x,lockOnTarget.y,functionalSpeed*1.25,false);
				}
			}

			// if idle or recovering, attack or perform next attack in chain (if aggressiveness allows)
			// TODO refactor this to support combatants without conventional l/r hands
			if attackNumberInChain == noone || ds_map_find_value(recoveringLimbs,prevAttackLimb) == attackNumberInChain {

				// decide if we should attack (maybe again, if there's another attack in the chain)
				var willAttack = false;
				var a = !isRanged ? meleeAttacks[attackNumber] : rangedAttacks[attackNumber];
				var aLength = array_length_1d(a); // how many attacks in the chain there are
				var nextAttackInChainExists =  aLength >= attackNumberInChain + 1;

				// if there's another attack in the chain and we've already attacked once (i.e. attackNumberInChain is not null)
				if nextAttackInChainExists && attackNumberInChain {
					attackNumberInChain++;
				} else {
					willAttack = false;
				}
			
				// if this is the first attack in chain (i.e. combatant has not attacked yet) definitely attack
				if attackNumberInChain == noone {
					attackNumberInChain = 1;
					willAttack = true;
				}
				// if this isn't the first attack in chain and there is another attack in chain, decide based on aggresiveness
				else if (nextAttackInChainExists && !hasCalculatedNextAttack) {
					// NEW: if a chain has started, it will keep going until it's over or stamina is out
					willAttack = true; 
				}
			
				// attack logic
				if willAttack && stamina > 0 {
					var lk = "r";
					if !isRanged{
						var a = meleeAttacks[attackNumber];
					} else var a = rangedAttacks[attackNumber];
					var attackData = a[attackNumberInChain - 1];
					if hasHands && !isRanged {
						
						var limbKeyInData = attackData.limbKey;
						switch limbKeyInData {
							case "e": {
								randomize();
								var rand = random_range(0,1);
								lk = rand - .5 > 0 ? "r" : "l";
								break;
							}
							case "s": {
								lk = prevAttackLimb;
								break;
							}
							case "o": {
								lk = prevAttackLimb == "r" ? "l" : "r";
								break;
							}
							default: {
								lk = limbKeyInData;
								break;
							}
						}
					}
					// ranged is always 2h and always "in" the left hand
					if hasHands && isRanged {
						lk = "l";
					}
					
					var spriteAttackNumber = attackData.spriteAttackNumber;
					var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
					
					// start attack prep -- ONLY IF this limb is not currently busy
					var prepSprite = asset_get_index(attackData.spriteName+"_prep_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
					ds_map_replace(preparingLimbs,lk,attackNumberInChain);
					ds_map_replace(prepFrameTotals,lk,sprite_get_number(prepSprite));
					ds_map_replace(prepFrames,lk,-1);
					
					// if this same hand was recovering before, stop that
					if ds_map_find_value(recoveringLimbs,lk) != undefined {
						ds_map_delete(recoveringLimbs,lk);
						ds_map_replace(recoverFrames,lk,-1);
						ds_map_replace(recoverFrameTotals,lk,0);
					}
				} 
			} 

			// iterate over the preparing limbs to see if an attack should fire
			iterateOverPreparingLimbs();
			
			// attack animation frame logic shit is in obj_attack
			
			// update attackFrames values
			updateAttackFrames();
			
			// maybe move forward if this is a melee attack
			maybeMoveDuringAttack();

			// iterate over the recover frames for all limbs to see if an attack is ended
			iterateOverRecoveringLimbs();

			// get out of attack sequence
			if ds_map_size(preparingLimbs) == 0 && ds_map_size(recoveringLimbs) == 0 && ds_map_size(attackingLimbs) == 0 {
				currentMeleeAttack = noone;
				currentRangedAttack = noone;
				stupidityFrame = 0;
				state = CombatantStates.Idle;
				hasCalculatedNextAttack = false;
				attackFrequencyTotalFrames = attackData.coolDownFrames;
			}
		}
		break;
	}
	case CombatantStates.Wary: {
		if lockOnTarget == noone lockOnTarget = global.player;
		// do not stay in wary state if lockOnTarget is out of sight
		var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
		if wallsBetweenTarget != noone {
			waryFrame = 0;
			ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
		}
		
		// if waryFrame is 0, return to Move state
		if waryFrame == 0 {
			state = CombatantStates.Moving;
		}
		// calculate -- will we dodge during this Wary state?
		// if we've not yet calculated if we'll dodge during this Wary state, calculate that now
		// this is calculated only once per Wary state
		calculateWillDodge();
		if maybeDodge() break; 
		
		// if not at wary distance, get there
		moveToWaryDistance();
		
		if !hasReachedWaryDistance && distance_to_object(obj_solid_parent) == 0 {
			hasReachedWaryDistance = true;
		}
		
		// if we've reach wary distance and the target's getting too close, return to move state
		if distance_to_object(lockOnTarget) < .5*waryDistance && hasReachedWaryDistance {
			hasCalculatedWillDodge = false;
			state = CombatantStates.Moving;
		}
		
		// if at wary distance, strafe
		if hasReachedWaryDistance {
			var orbit = point_distance(x,y,lockOnTarget.x,lockOnTarget.y);
			if orbit > 250 {
				orbit -= 1;
			}
			strafeAroundPoint(lockOnTarget.x,lockOnTarget.y,functionalSpeed*.1,orbit);
		}
		
		// always decrement waryFrame
		waryFrame--;
		
		break;
	}
	case CombatantStates.Dodging: {
		// actual dodge
		if dodgeFrame == 0 && isFairy {
			global.condition = "FairyDodge";
			global.owner = id;
			instance_create_depth(x,y,1,obj_condition_particles);
		}
		dodge();
		// if not dodging, reset some states and values
		if dodgeFrame >= totalDodgeFrames {
			
			// reset dodgeFrequencyFrame for AI combatant
			if type != CombatantTypes.Player {
				randomize();
				dodgeFrequencyFrame = random_range(dodgeFrequencyFrames[0],dodgeFrequencyFrames[1]);
			}
			
			dodgeStartX = noone;
			dodgeStartY = noone;
			stupidityFrame = 0;
			dodgeFrame = 0;
			dodgeDirection = noone;
			
			// possibly become wary
			if maybeBecomeWary() break;
			state = CombatantStates.Moving;
		}
		break;
	}
	case CombatantStates.Staggering: {
		
		// stop attacking 
		stopAllAttacks();
		
		// stagger
		stagger();
		
		if (staggerFrame >= staggerDuration) {
			staggerDuration = 0;
			staggerFrame = 0;
			speed = 0;
			staggerSpeed = noone;
			
			// possibly become wary (less chance after stagger than dodging)
			// don't do this if the player is using ranged attacks
			if lastAttackHitWith != noone && instance_exists(lastAttackHitWith) && !lastAttackHitWith.isRanged {
				if maybeBecomeWary(1.5) break;
			}
			state = CombatantStates.Idle;
		}
		break;
	}
}

// flinching just moves you back a little in a given direction
// its like staggering but doesnt interrupt attacks
if isFlinching {
	flinch();
}

// always increment jumpFrames if jumping
if jumpFrame <= jumpTotalFrames {
	jumpFrame++;
}

// check if we should be falling
with obj_fallzone {
	var d = point_in_rectangle(other.bbox_left+10,other.bbox_top+10,bbox_left,bbox_top,bbox_right,bbox_bottom);
	var e = point_in_rectangle(other.bbox_right-10,other.bbox_bottom-10,bbox_left,bbox_top,bbox_right,bbox_bottom);
	if	d && e && layer == other.layer {
		other.fallFrame = 0;
		other.floorsFallen = 1;
	}
}

// if colliding with a solid object, jump to nearest free point
// this mainly resolves issues when enemies are using mp_grids and suddenly switch to mp_potential_* stuff
if type == CombatantTypes.Enemy {
	if !place_free(x,y) {
		jumpToNearestFreePoint(true);
	}
}

