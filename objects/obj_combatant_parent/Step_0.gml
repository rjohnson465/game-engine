if isFloating {
	functionalSpeed = normalSpeed*slowedSpeedModifier*equipLoadSpeedModifier;
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
	fall(mightFallOffRidge);
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

// no matter what state we're on, we should only ever shield for <shieldFrames> frames
if type != CombatantTypes.Player {
	maybeStopShielding();
}

// huge state machine
switch(state) {
	case CombatantStates.Idle: {
		
		// player overrides this
		if type != CombatantTypes.Player && usesDefaultIdleState {
			isTurning = false;
			isMoving = false;
			isStrafing = false;
			speed = 0;
			onAlert = false;
			var actingPostX = postX;
			var actingPostY = postY;
			if getLayerFloorNumber(layer) != postZ {
				actingPostX = tempPostX;
				actingPostY = tempPostY;
			}
			
			// if not on player layer or very far from player and and close to post, just stand still
			if (layer != global.player.layer && distance_to_point(actingPostX,actingPostY) < 10) || distance_to_object(obj_player) > 1000 {
				lockOnTarget = noone;
				break;
			}
			
			// isNoticingEngagement -- if there is some ally you can see that has a lockOnTarget, try aggroing
			var allyType = object_is_ancestor(object_index,obj_enemy_parent) ? obj_enemy_parent : obj_goodguy_parent;
			var isNoticingEngagement = false;
			// only perform this check every so often
			if alarm[1] == 1 {
				with allyType {
				
					var minRange = rangedAggroRange > 0 ? rangedAggroRange : 800;
				
					if layer == other.layer && lockOnTarget != noone && distance_to_object(other) < minRange {
						var wallsBetweenAlly = scr_collision_line_list_layer(x,y,other.x,other.y,obj_wall_parent,true,true);
					
						if wallsBetweenAlly != noone {
							// must be able to see this ally's engagement
							var dirToAlly = point_direction(other.x,other.y,x,y);
						
							// also, that ally must be able to see their lockOnTarget
							var canAllySeeTarget = false;
							with (other) {
								if canSeeLockOnTarget() {
									canAllySeeTarget = true;
								}
							}
						
							if angleBetween(other.x-sightAngleDelta,other.y+sightAngleDelta,dirToAlly) && canAllySeeTarget {
								isNoticingEngagement = true;
							}
						}
						if wallsBetweenAlly != noone && ds_exists(wallsBetweenAlly, ds_type_list) {
							ds_list_destroy(wallsBetweenAlly); wallsBetweenAlly = -1;
						}
					}
				
				}
			}
			
			var biggestAggroRange = meleeAggroRange > rangedAggroRange ? meleeAggroRange : rangedAggroRange;
			var distToLockOnTargetType = distance_to_object(lockOnTargetType);
			if alarm[1] == 1 && distToLockOnTargetType < biggestAggroRange &&  maybeAggro() {
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
				startInvestigation(); break;
			}
			// else, check if the player is just too goddamn close 
			else if global.player.visible && distance_to_object(global.player) < minAggroRange {
				if array_length_1d(meleeAttacks) > 0 {
					state = CombatantStates.AggroMelee; break;
				} else {
					state = CombatantStates.AggroRanged; break;
				}
			}
			// if no aggro and not at postX/postY, head back there
			else if distance_to_point(postX, postY) > 10 && getLayerFloorNumber(layer) == postZ {
				state = CombatantStates.Moving;
				substate = CombatantMoveSubstates.ReturningToPost;
				break;
			} else {
				showHp = false;
			}
			
			break; // end Idle state
		} break;
	}
	case CombatantStates.AggroMelee: {
		if type == CombatantTypes.Player break;
		// jumpToNearestFreePoint(true, true);
		chooseMeleeAttack();
		break;
	}
	case CombatantStates.AggroRanged: {
		if type == CombatantTypes.Player break;
		// jumpToNearestFreePoint(true, true); 
		chooseRangedAttack();
		break;
	}
	case CombatantStates.Moving: {
		// player overrides this entirely
		if type != CombatantTypes.Player && usesDefaultMoveState {
			if substate == noone substate = CombatantMoveSubstates.Chasing;
			// face the proper directionmaybe
			faceMovingDirection();
			
			// play proper moving sound -- walk sound, strafe sound, no sound...
			// playProperMovingSound();
			
			// be listening for any commotion, if you're not already in a fight
			if substate != CombatantMoveSubstates.Chasing && canHearNearbyHit() {
				// if already investigating, reset investigation point to this new sound
				if substate == CombatantMoveSubstates.Investigating {
					investigatingFrame = 0;
				}
				startInvestigation();
			}
			
			switch substate {
				
				// precondition: we have a lockOnTarget
				case CombatantMoveSubstates.Chasing: {
					
					// maybe leash back to post
					var actingPostX = postX;
					var actingPostY = postY;
					if getLayerFloorNumber(layer) != postZ {
						actingPostX = tempPostX;
						actingPostY = tempPostY;
					}
					// only leash if player is not close to enemy? i.e. player is probably fleeing
					if distance_to_point(actingPostX,actingPostY) >= farthestAllowedFromPost && distance_to_object(lockOnTarget) > 200 {
						state = CombatantStates.Moving;
						substate = CombatantMoveSubstates.ReturningToPost;
						break;
					}
					
					// CHECK 1: WILL WE GO WARY?
					if waryCheckFrame <= 0 {
						var lowerBound = waryCheckTotalFrames[0];
						var upperBound = waryCheckTotalFrames[1];
						var rand = random_range(lowerBound, upperBound);
						waryCheckFrame = rand;
						// maybe become wary based on skittishness and proximity to target
						if maybeBecomeWary() && distance_to_object(lockOnTarget) < 150 {
							break;
						}
					} else {
						waryCheckFrame--;
					}
					
					// CHECK 2: WILL WE DODGE IN THIS MOVE STATE?
					if maybeDodge() break;
					// CHECK 3: WILL WE SHIELD IN THIS MOVE STATE?
					maybeShield();
					
					if lockOnTarget != noone && instance_exists(lockOnTarget) && lockOnTarget.layer != layer {
						lockOnTarget = noone;
					}
					
					// CHECK 4: Maybe switch to melee / range
					if (lockOnTarget != noone) {
						var isGridPathAvailable = getIsGridPathAvailable(false);				
						if currentMeleeAttack > -1 && 
							((distance_to_object(lockOnTarget) > meleeAggroRange || array_length_1d(meleeAttacks) == 0) || (!isGridPathAvailable))
							&& 
							canSeeLockOnTarget() && array_length_1d(rangedAttacks) > 0 {
							state = CombatantStates.AggroRanged; break;
						}
						
						// not switching melee / range, but maybe choose a different attack
						// based on how far away from target we are
						if reassessAttackFrame == 0 {
							if currentMeleeAttack > -1 {
								chooseMeleeAttack();
							} else if currentRangedAttack > -1 {
								chooseRangedAttack();
							}
						}
				
						// if we're not in range for attack, do this
						if maybeMoveNotInAttackRange() {
							isStrafing = false;
							break;
						}
						// within range for attack
						else {
							moveInAttackRange();
							break;
						}
						break;
					} 
					// if we have no lock on target anymore, return to post
					else {
						state = CombatantStates.Moving;
						substate = CombatantMoveSubstates.ReturningToPost;
					}
				}
				case CombatantMoveSubstates.Investigating: {
					
					if global.player.layer != layer {
						substate = CombatantMoveSubstates.ReturningToPost;
						break;
					}
					
					onAlert = true;
					// can aggro while investigating sound
					if maybeAggro() {
						investigationPtX = noone; investigationPtY = noone;
						investigatingFrame = 0; onAlert = false;
						break;
					}
					// pursue the source of the sound, if not close enough
					// TODO -- ensure the investigationPt will have a gridPath to it
					var cellX = investigationPtX div cell_width;
					var cellY = investigationPtY div cell_height;
					var invPCell = mp_grid_get_nearest_free_cell(personalGrid, cellX, cellY, cell_width, cell_height);
					cellX = invPCell[0]; cellY = invPCell[1];
					investigationPtX = cellX * cell_width;
					investigationPtY = cellY * cell_height;
					if distance_to_point(investigationPtX,investigationPtY) > 25 && investigatingFrame <= 0 {
						if mp_grid_path(personalGrid,path,x,y,investigationPtX,investigationPtY,0) {
							path_start(path,functionalSpeed,path_action_stop,false);
						} 
					}
					// we've reached the source of the sound
					else {
						// look around before giving up
						if investigatingFrame <= investigatingFramesTotal {
							maybeInvestigate();	// maybe wander around the sound point
							if maybeAggro() {
								investigationPtX = noone; investigationPtY = noone;
								break;
							}
						}
						// return to post if done investigating
						else {
							investigatingFrame = 0;
							investigationPtX = noone; investigationPtY = noone;
							substate = CombatantMoveSubstates.ReturningToPost;
							onAlert = false;
							break;
						}
					}
					break;	
				}
				case CombatantMoveSubstates.ReturningToPost: {
					var actingPostX = postX;
					var actingPostY = postY;
					if getLayerFloorNumber(layer) != postZ {
						actingPostX = tempPostX;
						actingPostY = tempPostY;
					}
					if distance_to_point(actingPostX,actingPostY) > 2 {
						mp_grid_path(personalGrid,path,x,y,actingPostX,actingPostY,0);
						path_start(path,functionalSpeed,path_action_stop,false);
						
						// can aggro if player gets too close or is hit
						if distance_to_object(lockOnTargetType) < meleeAggroRange {
							maybeAggro();
						}
						
					} else {
						facingDirection = postDir;
						state = CombatantStates.Idle;
						lockOnTarget = noone;
						showHp = false;
						break;
					}
					break;
				}
			}
			break;
		} break;
	}
	case CombatantStates.Attacking: {
		
		// THIS IS ONLY FOR ENEMY / ALLY
		// figure out what attack to perform / what number in chain
		if type != CombatantTypes.Player {
			
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			if attackNumber == noone break;
			var isRanged = currentRangedAttack != noone;
			
			// find attack data object
			attackData = noone;
			var attackChain = isRanged ? rangedAttacks[attackNumber] : meleeAttacks[attackNumber];
			if attackNumberInChain == noone {
				attackData = attackChain[0];
			} else {
				attackData = attackChain[attackNumberInChain-1];
			}
			
			// get previous attacking limb
			if attackNumberInChain == noone && !isRanged && hasHands {
				var attackChain = meleeAttacks[attackNumber];
				attackData = attackChain[0];
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
			
			// maybe switch weapons, if the attack we've chosen (attackData) specifies 
			// a weapon we do not have equipped at the moment
			if attackData != noone && attackData.weaponRequired != noone {
				maybeSwitchWeapons();
			}
			
			// aim when preparing attack
			if ds_map_size(preparingLimbs) != 0 && ds_map_size(attackingLimbs) == 0 /*&& ds_map_size(recoveringLimbs) == 0*/ && attackData.type != AttackTypes.AOE {
				turnToFacePoint(attackData.turnSpeed,lockOnTarget.x,lockOnTarget.y);
			}
			
			// it's posslbe we're out of range again, especially if the lockOnTarget staggered or ran. try getting in range again
			if !isRanged && ds_map_size(preparingLimbs) !=0 && attackData.type != AttackTypes.Charge && attackData.type != AttackTypes.AOE && attackData.movesDuringPrep {
				if distance_to_object(lockOnTarget) > getRangeForAttackIndex(currentMeleeAttack,true) /*meleeRangeArray[currentMeleeAttack]*/ && !place_meeting_layer(x,y,lockOnTarget) {
					mp_potential_step(lockOnTarget.x,lockOnTarget.y,normalSpeed*.5,false);
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
				if willAttack /*&& stamina > 0*/ {
					var lk = "r";
					if !hasHands lk = attackData.limbKey;
					if !isRanged{
						var a = meleeAttacks[attackNumber];
					} else var a = rangedAttacks[attackNumber];
					attackData = a[attackNumberInChain - 1];
					if hasHands /*&& !isRanged*/ {
						
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
							case noone: {
								lk = noone; break;
							}
							default: {
								lk = limbKeyInData;
								break;
							}
						}
					}
					/* 
					// ?????
					// ranged is always 2h and always "in" the left hand
					if hasHands && isRanged {
						lk = "l";
					}
					*/
					
					var spriteAttackNumber = attackData.spriteAttackNumber;
					var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
					
					// start attack prep -- ONLY IF this limb is not currently busy
					var prepSprite = asset_get_index(attackData.spriteName+"_prep_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
					ds_map_replace(preparingLimbs,lk,attackNumberInChain);
					ds_map_replace(prepFrameTotals,lk,sprite_get_number(prepSprite));
					ds_map_replace(prepFrames,lk,-1);
					
					// prep sound stuff
					if attackData.prepSound != noone {
						if audio_emitter_exists(attackPrepSoundEmitter) { 
							audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
						}
				
						attackPrepSoundEmitter = audio_emitter_create();
						audio_emitter_falloff(attackPrepSoundEmitter, 50, AUDIO_MAX_FALLOFF_DIST, .1);
						audio_emitter_gain(attackPrepSoundEmitter, 1);
						audio_play_sound_on(attackPrepSoundEmitter,attackData.prepSound,0,1);
					}
					
					// prep sound vox
					if array_length_1d(attackData.prepSoundsVocals) > 0 {
						randomize();
						var rand = floor(random_range(0, array_length_1d(attackData.prepSoundsVocals)));
						var prepSoundVocal = attackData.prepSoundsVocals[rand];
				
						if (!audio_emitter_exists(attackPrepSoundEmitter)) {
							attackPrepSoundEmitter = audio_emitter_create();
							audio_emitter_falloff(attackPrepSoundEmitter, 50, AUDIO_MAX_FALLOFF_DIST, .1);
							audio_emitter_gain(attackPrepSoundEmitter, 1);
						}
						audio_emitter_gain(attackPrepSoundEmitter, 1);
						audio_play_sound_on(attackPrepSoundEmitter,prepSoundVocal,0,1);
					}
					
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
				//state = CombatantStates.Idle;
				hasCalculatedNextAttack = false;
				attackFrequencyTotalFrames = attackData.coolDownFrames;
				maybeMarkGridCellTempFree(x, y);
				//alarm[1] = 2; // idle state checks aggro only when alarm[1] is 1
				if maybeAggro() {
					break;
				}
				else {
					state = CombatantStates.Idle;
					// jumpToNearestFreePoint(true, true);
				}
			}
		}
		break;
	}
	case CombatantStates.Wary: {
	
		// play proper moving sound -- walk sound, strafe sound, no sound...
		// playProperMovingSound();
	
		if lockOnTarget == noone lockOnTarget = global.player;
		// do not stay in wary state if lockOnTarget is out of sight
		var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
		if wallsBetweenTarget != noone {
			waryFrame = 0;
			ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
		}
		
		// if waryFrame is 0, return to Move state
		if waryFrame == 0 {
			maybeMarkGridCellTempFree(x,y);
			state = CombatantStates.Moving;
		}
		// calculate -- will we dodge during this Wary state?
		// if we've not yet calculated if we'll dodge during this Wary state, calculate that now
		// this is calculated only once per Wary state
		calculateWillDodge();
		if maybeDodge() {
			isStrafing = false;
			break; 
		}
		
		// if not at wary distance, get there
		moveToWaryDistance();
		
		if !hasReachedWaryDistance && distance_to_object(obj_solid_parent) == 0 {
			hasReachedWaryDistance = true;
		}
		
		// if we've reach wary distance and the target's getting too close, return to move state
		var closestAllowedDist = .5*waryDistance < 200 ? .5*waryDistance : 200;
		if distance_to_object(lockOnTarget) < closestAllowedDist && hasReachedWaryDistance {
			hasCalculatedWillDodge = false;
			hasCalculatedWillShield = false;
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
			
			jumpToNearestFreePoint(type == CombatantTypes.Enemy);
			
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
			// staggerSpeed = noone;
			
			// at final frame of staggering, maybe mark your spot as free in your personalGrid
			maybeMarkGridCellTempFree(x, y);
			
			// possibly become wary (less chance after stagger than dodging)
			// don't do this if the player is using ranged attacks
			if lastAttackHitWith != noone && instance_exists(lastAttackHitWith) && !lastAttackHitWith.isRanged {
				if maybeBecomeWary(1.5) break;
			}
			if type != CombatantTypes.Player && maybeAggro() {
				break;
			}
			else {
				state = CombatantStates.Idle;
			}
			// state = CombatantStates.Idle;
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
if jumpFrame = 0 {
	// play jump sound at jump start 
	audio_play_sound_at(snd_dodge1, x, y, depth, 25, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
}
if jumpFrame <= jumpTotalFrames {
	audio_emitter_gain(walkingEmitter, 0);
	jumpFrame++;
} else {
	audio_emitter_gain(walkingEmitter, 1);
}

// check if we should be falling
// but you can't fall if you're on a bridge
var isOnBridge = false;
with obj_bridge_parent {
	var _pm = place_meeting(x, y, other);
	var _layers =  origLayer == other.layer;
	if _pm  && _layers {
		isOnBridge = true;
	}
}

if !isOnBridge && place_meeting(x, y, obj_fallzone) { 
	with obj_fallzone {
		
		var d, e, a, b;
		
		if object_index == obj_fallzone_precise {
			var sw = sprite_get_width(sprite_index);
			var sh = sprite_get_height(sprite_index);
			var w = sw * image_xscale;
			var h = sh * image_yscale;
			var diagonalLength = sqrt(sqr(w) + sqr(h));
			var sinA = h / diagonalLength;
			var a = image_angle - radtodeg(arcsin(sinA));
			var p1x = x; var p1y = y;
			var p2x = x + lengthdir_x(w, image_angle); var p2y = y + lengthdir_y(w, image_angle);
			var p3x = x + lengthdir_x(diagonalLength, a); var p3y = y + lengthdir_y(diagonalLength, a);
			var p4x = x + lengthdir_x(h, image_angle - 90); var p4y = y + lengthdir_y(h, image_angle - 90);
		
			//d = pointInPolygon([other.x,other.y],[[p1x, p1y], [p2x, p2y], [p3x, p3y], [p4x, p4y]]);
			d = pointInPolygon([other.bbox_left+10,other.bbox_top+10],[[p1x, p1y], [p2x, p2y], [p3x, p3y], [p4x, p4y]]);
			e = pointInPolygon([other.bbox_right-10,other.bbox_bottom-10],[[p1x, p1y], [p2x, p2y], [p3x, p3y], [p4x, p4y]]);
			//e = d;
			
			a = pointInPolygon([other.bbox_left,other.bbox_top],[[p1x, p1y], [p2x, p2y], [p3x, p3y], [p4x, p4y]]);
			b = pointInPolygon([other.bbox_right,other.bbox_bottom],[[p1x, p1y], [p2x, p2y], [p3x, p3y], [p4x, p4y]]);
		} else {
			d = point_in_rectangle(other.bbox_left+10,other.bbox_top+10,bbox_left,bbox_top,bbox_right,bbox_bottom);
			e = point_in_rectangle(other.bbox_right-10,other.bbox_bottom-10,bbox_left,bbox_top,bbox_right,bbox_bottom);
	
			a = point_in_rectangle(other.bbox_left,other.bbox_top,bbox_left,bbox_top,bbox_right,bbox_bottom);
			b = point_in_rectangle(other.bbox_right,other.bbox_bottom,bbox_left,bbox_top,bbox_right,bbox_bottom);
		}
		
	
		if	d && e && layer == other.layer {
			image_blend = c_red;
			isFalling = true;
			other.fallFrame = 0;
			other.floorsFallen = 1;
		} else if other.type != CombatantTypes.Player && layer == other.layer && other.state == CombatantStates.Idle && !other.isFlinching && (d || e || a || b) {
			// if you're touching a fallzone but not falling yet...
			with other {
				if instance_exists(lockOnTarget) {
					mp_potential_step(lockOnTarget.x, lockOnTarget.y, functionalSpeed, false);
				}
			}
		}
	}
}

// maybe fall off ridge??
var nearestRidge = instance_nearest(x, y, obj_ridge);
if distance_to_object(nearestRidge) < 32 {
	// check if standing on ridge mostly
	var isStandingOnRidgeStill = false;
	with obj_ridge {
		var intersectArea = rectsIntersectionArea(
			other.bbox_left, other.bbox_top, other.bbox_right, other.bbox_bottom,
			bbox_left, bbox_top, bbox_right, bbox_bottom
		);
		if intersectArea > 500 {
			isStandingOnRidgeStill = true;
		}
	}
	// if !place_meeting_layer(x,y,obj_ridge) && mightFallOffRidge {
	if !isStandingOnRidgeStill && mightFallOffRidge {
		isFalling = true;
		fallFrame = 0;
		fall(mightFallOffRidge);
	}
}


// position water emitter, conditions emitters
audio_emitter_position(walkingInWaterEmitter,x,y,depth);
audio_emitter_position(walkingEmitter,x,y,depth);
var cc = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap, cc);
	audio_emitter_position(emitter,x,y,depth);
	cc = ds_map_find_next(conditionsEmittersMap, cc);
}

playProperMovingSound();

/*
if walkingSound != noone {
	if isAlive && ((state == CombatantStates.Moving && isMoving) || isTurning || isStrafing) {
		if walkingSoundIndex = noone {
			walkingSoundIndex = audio_play_sound_on(walkingEmitter, walkingSound, 1, 1);
		}
		audio_emitter_gain(walkingEmitter,1);
	} else {
		audio_stop_sound(walkingSoundIndex);
		walkingSoundIndex = noone;
		audio_emitter_gain(walkingEmitter,0);
	}
}

