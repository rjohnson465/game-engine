// Reset personal grid for allies / enemeies
// The personal grid allows for allies / enemies to plan their path, acommodating walls and other combatants
if type != CombatantTypes.Player {
	mp_grid_clear_all(personalGrid);
	mp_grid_add_instances(personalGrid,obj_wall_parent,true);
	var combatants = script_execute(scr_get_ids_region,obj_combatant_parent,0,0,room_width,room_height);
	for (var i = 0; i < ds_list_size(combatants); i++) {
		var ci = ds_list_find_value(combatants,i);
		if ci != id && ci != global.player.id {
			mp_grid_add_instances(personalGrid,ds_list_find_value(combatants,i),true);
		} 
	}
}

// stamina / health regen
// only regen stamina when moving or idle
if stamina < maxStamina && (state == CombatantStates.Idle || state == CombatantStates.Moving) {
	// stamina regens slower if shielding
	if isShielding {
		stamina += (.5*staminaRegen)/40;
	}
	else stamina += staminaRegen/40;
}
if hp < maxHp {
	hp += hpRegen/40;
}

// conditionPercentages drain every step
// TODO Devin fix calculations for draining
var currentCondition = ds_map_find_first(conditionPercentages);
var size = ds_map_size(conditionPercentages);
for (var i = 0; i < size; i++){
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	
	// if condition is ice and just went over 50, apply slow
	if conditionPercent > 50 && currentCondition == ICE && ds_map_find_value(conditionLevels,currentCondition) == 0 {
		isSlowed = true;
		ds_map_replace(conditionLevels,currentCondition,1);
	}
	
	// if condition is ice and it just dropped below 85 (coming from condition level 2, frozen), reset to condition level 1 (slow)
	if conditionPercent < 85 && currentCondition == ICE {
		if ds_map_find_value(conditionLevels,currentCondition) == 2 {
			isFrozen = false;
			isSlowed = true;
			ds_map_replace(conditionLevels,currentCondition,1);
		}
	}
	
	// generally, if conditionPercent exceeds 99, condition level becomes 1
	// except for ice, in which condition level becomes 2 (frozen)
	if conditionPercent > 95 && currentCondition == ICE {
		ds_map_replace(conditionLevels,currentCondition,2);
		// freeze applied on a burning target, burn is removed
		if !isFrozen && isBurning {
			ds_map_replace(conditionPercentages,FIRE,0);
			isBurning = false;
		}
		isSlowed = false;
		isFrozen = true;
	} else if conditionPercent > 95 {
		ds_map_replace(conditionLevels,currentCondition,1);
		switch currentCondition {
			case POISON: {
				isPoisoned = true; 
				lightRadiusColor = c_lime;
				lightRadiusAlpha = .75;
				break;
			}
			case FIRE: {
				// if burn applied on a slowed or frozen target, slow / frozen is removed
				if !isBurning && (isSlowed || isFrozen) {
					ds_map_replace(conditionPercentages,ICE,0);
					isSlowed = false;
					isFrozen = false;
				}
				isBurning = true; 
				lightRadiusColor = c_orange;
				lightRadiusAlpha = .75;
				break;
			}
			case LIGHTNING: {
				if !isShocked {
					// lower all defenses by a static (ha) amount
					var currentDefense = ds_map_find_first(defenses);
					for (var i = 0; i < ds_map_size(defenses); i++) {
						var defense = ds_map_find_value(defenses,currentDefense);
						ds_map_replace(defenses,currentDefense,defense-25);
						currentDefense = ds_map_find_next(defenses,currentDefense);
					}
				}
				isShocked = true; 				
				break;
			}
			case ICE: {
				// freeze applied on a burning target, burn is removed
				if !isFrozen && isBurning {
					ds_map_replace(conditionPercentages,FIRE,0);
					isBurning = false;
				}
				isFrozen = true; 
				isSlowed = false; break;
			}
		}
	}
	
	// drain condition levels
	if conditionPercent > 0 {
		var decrementAmount = 1/3;
		var defense = ds_map_find_value(defenses,currentCondition);
		//decrementAmount += 1-abs((defense/100));
		decrementAmount = defense > 0 ? decrementAmount + 1-(defense/100) : decrementAmount - 1-(defense/100);
		if decrementAmount < 0 {
			decrementAmount = .2;
		}
		conditionPercent -= decrementAmount;
		ds_map_replace(conditionPercentages,currentCondition,conditionPercent);
	} if conditionPercent <= 0 {
		ds_map_replace(conditionPercentages,currentCondition,0);
		// set condition level to 0
		ds_map_replace(conditionLevels,currentCondition,0);
		switch currentCondition {
			case FIRE: {
				isBurning = false; 
				burnDamage = 0; 
				if lightRadiusColor == c_orange {
					lightRadiusColor = c_white;
					lightRadiusAlpha = .25;
					lightRadiusSprite = spr_light_point;
				}
				break;
			}
			case ICE: {
				isSlowed = false; isFrozen = false; break;
			}
			case POISON: {
				isPoisoned = false; 
				poisonDamage = 0; 
				if lightRadiusColor == c_lime {
					lightRadiusColor = c_white;
					lightRadiusAlpha = .25;
					lightRadiusSprite = spr_light_point;
				}
				break;
			}
			case LIGHTNING: {
				if isShocked {
					// reset all defenses to normal values
					var currentDefense = ds_map_find_first(defenses);
					for (var i = 0; i < ds_map_size(defenses); i++) {
						var defense = ds_map_find_value(defenses,currentDefense);
						ds_map_replace(defenses,currentDefense,defense+25);
						currentDefense = ds_map_find_next(defenses,currentDefense);
					}
				}
				isShocked = false; 
				break;
			}
		}
	}
	
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}

// account for any currently active conditions (slowed/frozen, burning, poisoned, electrified)
var currentCondition = ds_map_find_first(conditionLevels);
var size = ds_map_size(conditionLevels);
for (var i = 0; i < size; i++){
	var conditionLevel = ds_map_find_value(conditionLevels,currentCondition);
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	var defense = ds_map_find_value(defenses,currentCondition);
	
	// particle effects for conditions
	if conditionLevel > 0 && currentCondition != MAGIC && currentCondition != PHYSICAL {
		var condParticlesExist = false;
		var c = currentCondition;
		var o = id;
		with (obj_condition_particles) {
			if condition == c && owner == o {
				condParticlesExist = true;
			}
		}
		if !condParticlesExist {
			global.condition = currentCondition;
			global.owner = id;
			instance_create_depth(x,y,1,obj_condition_particles);
		}
	}
	
	// set back old properties when conditions expire
	if conditionLevel <= 0 {
		switch currentCondition {
			case ICE: {
				functionalSpeed = normalSpeed;
			}
		}
	}
	else {
		switch currentCondition {
			case ICE: {
				// slowed
				if conditionLevel == 1 {
					//functionalSpeed = .5*normalSpeed;
					functionalSpeed = (1-(conditionPercent/100))*normalSpeed;
				}
				// frozen
				else if conditionLevel == 2{
					functionalSpeed = 0;
				}
				break;
			}
			// burning
			case FIRE: {
				// burn damage taken every 2 seconds by default
				// if fire defense is positive, defense% of 60 is added to burn frames
				burnFrames = (defense >= 0) ? burnFrames + burnFrames*(defense/100) : burnFrames - burnFrames*(defense/100);
				if burnFrame >= burnFrames {

					var originalBurnDamage = burnDamage;
					if burnDamage > hp {
						burnDamage = hp;
					}
					hp -= burnDamage;
					//if type != CombatantTypes.Player {
						global.damageAmount = burnDamage;
						global.victim = id;
						global.healingSustained = 0;
						instance_create_depth(x,y,1,obj_damage);
					//}
					// diminishes every pulse
					// TODO math major DEVIN
					burnDamage = originalBurnDamage;
					burnDamage = defense >= 0 ? 
						burnDamage - ((.25*burnDamage)-((.25*burnDamage)*(defense/100))) : 
						burnDamage - ((.25*burnDamage)+((.25*burnDamage)*(defense/100)));
					if burnDamage < 1 {
						burnDamage = 1;
					}
					burnFrame = 0;
				}
				burnFrame++;
				break;
			}
			// poisoned
			case POISON: {
				// poison damage taken every 2 seconds by default 
				// if poison defense is poistive, defense% of 60 is added to burn frames. if less, it is subtracted
				poisonFrames = (defense >= 0) ? poisonFrames + poisonFrames*(defense/100) : poisonFrames - poisonFrames*(defense/100);
				if poisonFrame >= poisonFrames {
					poisonDamage = defense >= 0 ? (poisonDamage - poisonDamage*(defense/100)) : (poisonDamage + poisonDamage*(defense/100));
					var originalPoisonDamage = poisonDamage;
					if poisonDamage > hp {
						poisonDamage = hp;
					}
					hp -= poisonDamage;
					
					//if type != CombatantTypes.Player {
						global.damageAmount = poisonDamage;
						global.victim = id;
						global.healingSustained = 0;
						instance_create_depth(x,y,1,obj_damage);
					//}
					// builds every pulse
					// TODO math major DEVIN
					poisonDamage = originalPoisonDamage;
					poisonDamage = defense >= 0 ? 
						poisonDamage + ((.25*poisonDamage)-((.25*poisonDamage)*(defense/100))) : 
						poisonDamage + ((.25*poisonDamage)+((.25*poisonDamage)*(defense/100)));
					poisonFrame = 0;
				}
				poisonFrame++;
				break;
			}
			case LIGHTNING: {
				// shock lowers defenses; this is handled just once, when lightning percent is set to 100; i.e. not here
			}
		}
	}
	
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}

// huge state machine
switch(state) {
	case CombatantStates.Idle: {
		// player overrides this
		if type != CombatantTypes.Player {
			
			// if there are other combatant instances within a certin distance not behind walls who are on alert, this instance will also be alerted
			var nearbyCombatants = script_execute(scr_get_ids_region,obj_enemy_parent,x-perception,y-perception,x+perception,x+perception);
			var isNoticingEngagement = false;
			for (var i = 0; i < ds_list_size(nearbyCombatants); i++) {
				var c = ds_list_find_value(nearbyCombatants,i);
				var wallsBetweenCombatant = script_execute(scr_collision_line_list,x,y,c.x,c.y,obj_wall_parent,true,true);
				if wallsBetweenCombatant == noone && c.onAlert && c.id != id {
					isNoticingEngagement = true;
				}
			}
			
			// think for stupidityFrames frames
			// TODO -- set onAlert to false after Idle for a while?
			if (stupidityFrame < stupidity) {
				speed = 0;
				stupidityFrame++;
				break;
			} else {
				// first check if in melee aggro range
				if canSeePlayer(id) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange {
					state = CombatantStates.AggroMelee;
					break;
				}
				// if not, check if in ranged aggro range
				else if canSeePlayer(id) && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
					state = CombatantStates.AggroRanged;
					break;
				}
				else if isNoticingEngagement || wasJustHit {
					wasJustHit = false;
					// first try ranged
					if array_length_1d(rangedAttacks) > 0 {
						state = CombatantStates.AggroRanged;
					} else state = CombatantStates.AggroMelee;
				}
				// if no aggro and not at postX/postY, head back there
				else if distance_to_point(postX, postY) > 1
				{
					state = CombatantStates.Moving;
					break;
				} else {
					// if we're back at post and not in any aggro ranges, just keep thinking
					stupidityFrame = 0;
					showHp = false;
					break;
				}
			}
			break;
		}
	}
	case CombatantStates.AggroMelee: {
		if type != CombatantTypes.Player {
			// pick a melee attack
			lockOnTarget = instance_nearest(x,y,lockOnTargetType);
			currentRangedAttack = noone;
			attackNumberInChain = noone;
			randomize();
			currentMeleeAttack = round(random_range(1,array_length_1d(meleeAttacks)));
			//currentMeleeAttack = 2;
			// close enough to hear, but maybe not see. turn to face the direction of the noise
			facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			var wallsBetweenTarget = script_execute(scr_collision_line_list,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
			if wallsBetweenTarget == noone || onAlert {
				onAlert = true;
				isShielding = false;
				rightHandItem = ds_map_find_value(handItems,"rm1");
				// TODO -- melee 2H accounting
				//if !rightHandItem.isTwoHanded {
				leftHandItem = ds_map_find_value(handItems,"lm1");
				//}
				state = CombatantStates.Moving;
			}
			break;
		}
	}
	case CombatantStates.AggroRanged: {
		if type != CombatantTypes.Player {
			// pick a ranged attack
			lockOnTarget = instance_nearest(x,y,lockOnTargetType);
			currentMeleeAttack = noone;
			attackNumberInChain = noone;
			currentRangedAttack = round(random_range(1,array_length_1d(rangedAttacks)));
			// close enough to hear, but maybe not see. turn to face the direction of the noise
			facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			var wallsBetweenTarget = script_execute(scr_collision_line_list,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
			if wallsBetweenTarget == noone || onAlert {
				onAlert = true;
				isShielding = false;
				rightHandItem = ds_map_find_value(handItems,"rr1");
				//if !rightHandItem.isTwoHanded {
				leftHandItem = ds_map_find_value(handItems,"lr1");
				//}
				state = CombatantStates.Moving;
			}
			break;
		}
	}
	case CombatantStates.Moving: {
		// player overrides this entirely
		if type != CombatantTypes.Player {
			// TODO pick target; may not always be player
			// if we've already chosen an attack during Idle state, we need to get close enough to target for that attack
			if currentMeleeAttack || currentRangedAttack {
				
				// CHECK 1: TOO FAR FROM POST?
				
				// if the path back to post is greater than farthestAllowedFromPost, cancel any pending attack 
				// this will trigger the return to post code (later in this case) on the next step
				var pathToPost = path_add();
				mp_grid_path(personalGrid, pathToPost,x,y,postX,postY,1);
				var pathToPostLength = path_get_length(pathToPost);
				if pathToPostLength > farthestAllowedFromPost {
					currentMeleeAttack = noone;
					currentRangedAttack = noone;
					break;
				}
				
				// CHECK 2: ARE WE OUT OF RANGE FOR THE CURRENTLY CHOSEN ATTACK?
				
				// if combatant was going to use a melee attack but their target is out of range and combatant has ranged attacks, switch to a ranged attack
				if currentMeleeAttack && distance_to_object(lockOnTarget) > meleeAggroRange && array_length_1d(rangedAttacks) > 0 {
					state = CombatantStates.AggroRanged;
					break;
				}
				// vice versa
				else if currentRangedAttack && distance_to_object(lockOnTarget) < meleeAggroRange && array_length_1d(meleeAttacks) > 0 {
					state = CombatantStates.AggroMelee;
					break;
				}
			
				// CHECK 3: WILL WE DODGE IN THIS MOVE STATE?
				
				// if we've not yet calculated if we'll dodge during this Move state, calculate that now
				// this is calculated only once per move state
				if !hasCalculatedWillDodge {
					randomize();
					var rand = random_range(1,100);
					show_debug_message(rand);
					willDodge = rand <= agility ? true : false;
					hasCalculatedWillDodge = true;
				}
				
				// CHECK 4: WILL WE SHIELD IN THIS MOVE STATE?
				if !willDodge && leftHandItem.type == HandItemTypes.Shield {
					// if within meleeAggroRange, check every shieldingFrames if should shield
					if !isShielding {
						if shieldingFrame < totalShieldingFrames && !hasCalculatedWillShield {
							randomize();
							totalShieldingFrames = random_range(shieldingFrequencyFrames[0],shieldingFrequencyFrames[1]);
							var rand = random_range(0,1);
							willShield = rand < (cautiousness/100);
							hasCalculatedWillShield = true;
						}
						else if shieldingFrame >= totalShieldingFrames && willShield {
							isShielding = true;
							global.owner = id;
							instance_create_depth(x,y,1,obj_shield_parent);
							shieldingFrame = 0;
						}
					} else {
						if shieldingFrame >= totalShieldingFrames {
							shieldingFrame = 0;
							hasCalculatedWillShield = false;
						}
					}
					shieldingFrame++;
				}
			
				// If we're close to our lockOnTarget and they're preparing attack and we've decided to dodge during this Move state,
				// decide exactly what frame in the lockOnTarget's attack prep to dodge on
				// TODO should combatants also pay attention to other enemies around them, other than just their lockOnTarget?
				// melee dodges
				var isMeleeAttack = false;
				// attackHand is the hand that is currently preparing but will finish preparation sooner
				var prepFrameL = ds_map_find_value(prepFrames,"l") == undefined ? 0 : ds_map_find_value(prepFrames,"l");
				var prepFrameLTotal = ds_map_find_value(prepFrameTotals,"l") == undefined ? 0 : ds_map_find_value(prepFrameTotals,"l");
				var prepFrameR = ds_map_find_value(prepFrames,"r") == undefined ? 0 : ds_map_find_value(prepFrames,"r");
				var prepFrameRTotal = ds_map_find_value(prepFrameTotals,"r") == undefined ? 0 : ds_map_find_value(prepFrameTotals,"r");
				var attackHand = 
					prepFrameL / prepFrameLTotal >= 
					prepFrameR / prepFrameRTotal ? "l" : "r";
				if lockOnTarget.type == CombatantTypes.Player {
					isMeleeAttack = attackHand == "l" ? lockOnTarget.leftHandItem.type == HandItemTypes.Melee : lockOnTarget.rightHandItem.type == HandItemTypes.Melee;
				} else {
					isMeleeAttack = lockOnTarget.currentMeleeAttack != noone;
				}
				var attackObj = instance_nearest(x,y,obj_attack);
				var range = 45; // the range at which to start attempting dodge. default is 45 pixels.
				// if dodging a player's melee attack, range is based on the melee weapon the player is using
				if lockOnTarget.type == CombatantTypes.Player && isMeleeAttack {
					var weapon = lockOnTarget.currentAttackingHand == "l" ? lockOnTarget.leftHandItem : lockOnTarget.rightHandItem;
					if weapon.range != 0 {
						range = weapon.range;
					}
				}
				// AI combatants have every attack range pre-loaded in attack data
				else if lockOnTarget.type != CombatantTypes.Player && isMeleeAttack {
					// TODO
				}
				// if the attack is coming from an Ally or Enemy, base it on their current attack range
				else if (lockOnTarget.type == CombatantTypes.Ally || lockOnTarget.type == CombatantTypes.Enemy) && isMeleeAttack {
					range = lockOnTarget.meleeRangeArray[lockOnTarget.currentMeleeAttack-1] + 10; // 10px padding
				}
				if distance_to_object(lockOnTarget) < range && ds_map_size(lockOnTarget.preparingHands) != 0 && willDodge && isMeleeAttack {
				
					// the more agile the enemy, the better chance it will dodge when player is almost done preparing attack
					randomize();
					
					// always dodge the furthest along in prep sequence attack if there a multiple preparing hands
					var prepFrame = ds_map_find_value(prepFrames,attackHand);
					var prepFrameTotal = ds_map_find_value(prepFrameTotals,attackHand);
					
					var percentDonePreparingAttack = prepFrame/prepFrameTotal;
					var percentageChangeEachFrame = 1/prepFrameTotal;
					// if agility - playerPercentDonePreparingAttack is the closest it can possibly be to percentageChangeEachFrame, yes, dodge this frame
					var testNum = (agility / 100) - percentDonePreparingAttack;
					var shouldDodgeOnThisFrame = false;
					var nextFrameTestNum = (agility / 100) - (percentDonePreparingAttack + percentageChangeEachFrame)
					var isNextFrameTooFar =  nextFrameTestNum <= percentageChangeEachFrame*2;
					if  isNextFrameTooFar {
						shouldDodgeOnThisFrame = true;
					}
					var willDodgeOnThisFrame = willDodge && shouldDodgeOnThisFrame;
				
					if willDodgeOnThisFrame && stamina > 0 && !isFrozen {
						facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
						hasCalculatedWillDodge = false;
						dodgeDirection = (facingDirection+180)%360;
						path_end();
						stamina -= 10;
						state = CombatantStates.Dodging;
						break;
					}
				}
				
				// ranged dodges TODO
				// if within range of a ranged attack object (projectile), time dodge based on agility (and if combatant can see the projectile)
				else if distance_to_object(obj_attack) < 200 - agility && script_execute(scr_is_facing,id,attackObj) && willDodge {
					if stamina > 0 && !isFrozen {
						facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
						hasCalculatedWillDodge = false;
						randomize();
						var rand = floor(random_range(1.01,2.99));
						dodgeDirection = rand == 1 ? (attackObj.direction+90)%360 : (attackObj.direction - 90 + 360)%360;
						path_end();
						stamina -= 10;
						state = CombatantStates.Dodging;
						break;
					}
				}
				
				// move to lockOnTarget until in range for chosen attack
				var wallsBetweenTarget = script_execute(scr_collision_line_list,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
				// TODO -- maybe move away from lockOnTarget if a rangedAttack has a minRange
				var pred = currentMeleeAttack == noone ? 
					// predicate for ranged attacks -- check that we're in range and there are no walls between us and target
					(distance_to_object(lockOnTarget) > rangedRangeArray[currentRangedAttack-1]) || wallsBetweenTarget != noone : 
					(distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack-1]);
				if pred && /*!isStrafing &&*/ !isFlinching {
					if wallsBetweenTarget == noone {
						facingDirection = point_direction(x,y,global.player.x,global.player.y);
					} else {
						facingDirection = direction;
					}
			
					// calculate path to lockOnTarget and move to it
					mp_grid_path(personalGrid, path, x,y, lockOnTarget.x,lockOnTarget.y,true);
					path_start(path,functionalSpeed,path_action_stop,true);

					break;

				}
				// within range for attack
				else {
					path_end();
					
					stupidityFrame = 100 - aggressiveness;
					
					if attackFrequencyFrame == -1 {
						randomize();
						attackFrequencyFrame = round(random_range(attackFrequencyTotalFrames[0],attackFrequencyTotalFrames[1]));
					} else if attackFrequencyFrame == 0 {
						// check if should enter attack state every x frames (some number between ranges specified in attackFrequencyTotalFrames)
						randomize();
						var rand = random_range(1,100);
						if rand <= aggressiveness {
							if !isFrozen {
								hasCalculatedWillDodge = false;
								isStrafing = false;
								state = CombatantStates.Attacking;
							}
						}
						attackFrequencyFrame--;
					} else {
						if currentMeleeAttack != noone {
							// strafe (maybe) and wait
							if strafeFrame == -1 {
								randomize();
								strafeFrame = round(random_range(strafeTotalFrames[0],strafeTotalFrames[1]));
								// check and see if will strafe this period
								randomize();
								var rand = random_range(1,100);
								if rand <= 75 {
									isStrafing = true;
									strafeAngle = point_direction(lockOnTarget.x,lockOnTarget.y,x,y);
									strafeDirection = rand < 37 ? "l" : "r";
								} else isStrafing = false;
							} else {
								if isStrafing {
									var dist = distance_to_object(lockOnTarget);
									if dist <= meleeRangeArray[currentMeleeAttack-1] {
										var angle = point_direction(lockOnTarget.x,lockOnTarget.y,x,y);
										angle = strafeDirection == "r" ? angle + functionalSpeed*.5 : angle - functionalSpeed*.5;
										var centerX = lockOnTarget.x;
										var centerY = lockOnTarget.y;
										var orbit = point_distance(x,y,lockOnTarget.x,lockOnTarget.y);		
										if dist < meleeRangeArray[currentMeleeAttack-1] {
											orbit += 1;
										}
										if angle >= 360 angle -= 360;
									
										var xx = lengthdir_x(orbit,angle) + centerX;
										var yy = lengthdir_y(orbit,angle) + centerY;
									
										if !place_meeting(xx,yy,obj_wall_parent) && !place_meeting(xx,yy,obj_combatant_parent) {
											x = xx;
											y = yy;
											facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
										} else {
											strafeDirection = strafeDirection == "l" ? "r" : "l";
										}
									}
								}
								strafeFrame--;
							}
						}
						attackFrequencyFrame--;
					}
					break;
				}
			}
		
			// TODO these checks should come back
			// if no attack is chosen, we're probably heading back to post
			// check no one is tryna gank us on our way back tho
			// first check if in melee aggro range
			/*else if meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange {
				state = CombatantStates.AggroMelee;
				break;
			}
			// if not, check if in ranged aggro range
			else if rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
				state = CombatantStates.AggroRanged;
				break;
			}*/
			else {
				mp_grid_clear_all(personalGrid);
				mp_grid_add_instances(personalGrid,obj_wall_parent,true);
				if mp_grid_path(personalGrid, path,x,y,postX,postY,true) {
					path_start(path,functionalSpeed*2,path_action_stop, false);
					facingDirection = direction;
				}
				if abs(postX-x) < 2 && abs(postY-y) < 2 {
					onAlert = false;
					path_end();
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
			var isRanged = currentRangedAttack != noone;
			
			// get previous attack hand
			if attackNumberInChain == noone && !isRanged && hasHands {
				var attackChain = meleeAttacks[attackNumber-1];
				var attackData = attackChain[0];
				var handSide = attackData.handSide;
				switch handSide {
					case "l": {
						prevAttackHand = "l";
						break;
					}
					case "r": {
						prevAttackHand = "r";
						break;
					}
					case "e": {
						randomize();
						var rand = random_range(0,1);
						prevAttackHand = rand - .5 > 0 ? "r" : "l";
						break;
					}
				}
			}
			
			if ds_map_size(preparingHands) != 0 {
				// aim while preparing attack
				facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			}
			
			if !isRanged && ds_map_size(preparingHands) !=0 {
				// it's posslbe we're out of range again, especially if the lockOnTarget staggered or ran. try getting in range again
				if distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack-1] {
					mp_potential_step(lockOnTarget.x,lockOnTarget.y,functionalSpeed*1.25,true);
				}
			}
		
			// if idle or recovering, attack or perform next attack in chain (if aggressiveness allows)
			// TODO refactor this to support combatants without conventional l/r hands
			if attackNumberInChain == noone || ds_map_find_value(recoveringHands,prevAttackHand) == attackNumberInChain {

				// decide if we should attack (maybe again, if there's another attack in the chain)
				var willAttack = false;
				var a = !isRanged ? meleeAttacks[attackNumber-1] : rangedAttacks[attackNumber-1];
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
					randomize();
					var rand = random_range(0,1);
					if rand <= (aggressiveness/100) {
						willAttack = true;
						hasCalculatedNextAttack = true;
					}
					else {
						hasCalculatedNextAttack = true;
						willAttack = false;
						attackNumberInChain--; // this is pretty sloppy
					}
				}
			
				// attack logic
				if willAttack && stamina > 0 {
					var handSide = "r";
					var attackData = a[attackNumberInChain - 1];
					if hasHands && !isRanged {
						var a = meleeAttacks[attackNumber-1];
						var side = attackData.handSide;
						switch side {
							case "l": {
								handSide = "l";
								break;
							}
							case "r": {
								handSide = "r";
								break;
							}
							case "e": {
								randomize();
								var rand = random_range(0,1);
								handSide = rand - .5 > 0 ? "r" : "l";
								break;
							}
							case "s": {
								handSide = prevAttackHand;
								break;
							}
							case "o": {
								handSide = prevAttackHand == "r" ? "l" : "r";
								break;
							}
						}
					}
					// for now, ranged is always 2h and always in the right hand
					if hasHands && isRanged {
						handSide = "r";
					}
					
					var spriteAttackNumber = attackData.spriteAttackNumber;
					var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
					
					// start attack prep -- ONLY IF this hand is not currently busy
					//if ds_map_find_value(preparingHands,handSide) == undefined && ds_map_find_value(attackingHands,handSide
					var prepSprite = asset_get_index(attackData.spriteName+"_prep_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
					ds_map_replace(preparingHands,handSide,attackNumberInChain);
					ds_map_replace(prepFrameTotals,handSide,sprite_get_number(prepSprite));
					ds_map_replace(prepFrames,handSide,0);
					
					// if this same hand was recovering before, stop that
					if ds_map_find_value(recoveringHands,handSide) != undefined {
						ds_map_delete(recoveringHands,handSide);
						ds_map_replace(recoverFrames,handSide,-1);
						ds_map_replace(recoverFrameTotals,handSide,0);
					}
				} 
				else {
					
					// loop through recoverFrames -- if a hand is at recoverFrame 0, that means it is beginning to recover
					var currentRecoverFrames = ds_map_find_first(recoverFrames);
					for (var i = 0; i < ds_map_size(recoverFrames); i++) {
						
						if ds_map_find_value(recoverFrames,currentRecoverFrames) == 0 {
							
							// the attack number in chain of the hand that was prepaing (but is about to be recovering)
							var numInChain = ds_map_find_value(attackingHands,currentRecoverFrames);
							if numInChain == undefined {
								numInChain = 1; // might be shit
							}
							ds_map_delete(attackingHands,currentRecoverFrames);
						
							var chainArray = meleeAttacks[attackNumber-1];
							var attackData = chainArray[numInChain-1];
							var spriteAttackNumber = attackData.spriteAttackNumber;
							var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
					
							var recoverSprite = asset_get_index(attackData.spriteName+"_recover_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
							
							prevAttackHand = currentRecoverFrames;
							if ds_map_find_value(recoveringHands,currentRecoverFrames) == undefined {
								ds_map_add(recoveringHands,currentRecoverFrames,numInChain);
							} else ds_map_replace(recoveringHands,currentRecoverFrames,numInChain);
							ds_map_replace(recoverFrameTotals,currentRecoverFrames,sprite_get_number(recoverSprite));
							ds_map_replace(recoverFrames,currentRecoverFrames,0);
						}
						
						currentRecoverFrames = ds_map_find_next(recoverFrames,currentRecoverFrames);
					}
				}
			} 
			
			// iterate over the prep frames for left and right hands to see if an attack should fire
			// TODO what about non humanoid attackers
			var currentPrepFrames = ds_map_find_first(prepFrames);
			for (var i = 0; i < ds_map_size(prepFrames); i++) {
				var prepFrame = ds_map_find_value(prepFrames,currentPrepFrames);
				var totalPrepFrames = ds_map_find_value(prepFrameTotals,currentPrepFrames);
				if prepFrame >= 0 && prepFrame >= totalPrepFrames {
					
					speed = 0;
					ds_map_replace(prepFrames,currentPrepFrames,-1);
					ds_map_replace(prepFrameTotals,currentPrepFrames,0);
					
					// stamina cost
					if hasHands {
						var currentAttackingHandItem = currentPrepFrames == "l" ? leftHandItem : rightHandItem;
						var attackInChain = ds_map_find_value(preparingHands,currentPrepFrames);
						var attackData = noone;
						if !isRanged {
							var attackChain = meleeAttacks[attackNumber-1];
							attackData = attackChain[attackInChain-1];
						} else {
							var attackChain = rangedAttacks[attackNumber-1];
							attackData = attackChain[attackInChain-1];
						}
						stamina -= attackData.staminaCost;
						ds_map_delete(preparingHands,currentPrepFrames);
						ds_map_replace(attackingHands,currentPrepFrames,attackInChain);
					}
					// this might be faintly retarded
					global.owner = id; // passed as param to attackObj
					global.handSide = currentPrepFrames;
					var attackObj = instance_create_depth(x,y,1,obj_attack);
					hasCalculatedNextAttack = false;
				}
				currentPrepFrames = ds_map_find_next(prepFrames,currentPrepFrames);
			}
			
			// attack animation frame logic shit is in enemy phys attack obj
			
			// iterate over the recover frames for left and right hands to see if an attack is ended
			var currentRecoverFrames = ds_map_find_first(recoverFrames);
			for (var i = 0; i < ds_map_size(recoverFrames); i++) {
				var recoverFrame = ds_map_find_value(recoverFrames,currentRecoverFrames);
				var totalRecoverFrames = ds_map_find_value(recoverFrameTotals,currentRecoverFrames);
				
				if recoverFrame == 0 {
					prevAttackHand = currentRecoverFrames;
				}
				
				if recoverFrame >= 0 && recoverFrame >= totalRecoverFrames {
					ds_map_delete(attackingHands,currentRecoverFrames);
					ds_map_replace(recoverFrames,currentRecoverFrames,-1);
					ds_map_replace(recoverFrameTotals,currentRecoverFrames,0);
				
					ds_map_delete(recoveringHands,currentRecoverFrames);	
				}
				currentRecoverFrames = ds_map_find_next(recoverFrames,currentRecoverFrames);
			}
			
			// get out of attack sequence
			if ds_map_size(preparingHands) == 0 && ds_map_size(recoveringHands) == 0 && ds_map_size(attackingHands) == 0 {
				//currentAttackingHand = noone;
				currentMeleeAttack = noone;
				currentRangedAttack = noone;
				attackNumberInChain = noone;
				stupidityFrame = 0;
				state = CombatantStates.Idle;
				hasCalculatedNextAttack = false;
			}
		}
		break;
	}
	case CombatantStates.Dodging: {
		attackNumberInChain = noone;
		isShielding = false;
		speed = 0;

		var x1 = x+lengthdir_x(functionalSpeed*2,dodgeDirection);
		var y1 = y+lengthdir_y(functionalSpeed*2,dodgeDirection);
		if !place_meeting(x1,y1,obj_solid_parent){
			speed = 2*functionalSpeed;
		} 
		direction = dodgeDirection;
		dodgeFrame++;
		// if not dodging, reset some states and values
		if dodgeFrame >= totalDodgeFrames {
			state = CombatantStates.Idle;
			stupidityFrame = 0;
			dodgeFrame = 0;
			dodgeDirection = noone;
		}
		break;
	}
	case CombatantStates.Staggering: {
		// stop attacking -- TODO need to fix this for non-humanoid combatants
		if hasHands {
			// stop preparing attacks
			if ds_map_size(preparingHands) != 0 {
				var hand = ds_map_find_first(preparingHands);
				for (var i = 0; i < ds_map_size(preparingHands); i++) {
					ds_map_replace(prepFrames,hand,-1);
					ds_map_replace(prepFrameTotals,hand,0);
					ds_map_delete(preparingHands,hand);
					hand = ds_map_find_next(preparingHands,hand);
				}
			}
			// stop attacking
			if ds_map_size(attackingHands) != 0 {
				var hand = ds_map_find_first(attackingHands);
				for (var i = 0; i < ds_map_size(attackingHands); i++) {
					ds_map_delete(attackingHands,hand);
					hand = ds_map_find_next(attackingHands,hand);
				}
			}
			// stop recovering attacks
			if ds_map_size(recoveringHands) != 0 {
				var hand = ds_map_find_first(recoveringHands);
				for (var i = 0; i < ds_map_size(recoveringHands); i++) {
					ds_map_replace(recoveringHands,hand,-1);
					ds_map_replace(recoveringHands,hand,0);
					ds_map_delete(recoveringHands,hand);
					hand = ds_map_find_next(recoveringHands,hand);
				}
			}
		}
		isStrafing = false;
		currentAttackingHand = noone;
		currentUsingSpell = noone;
		attackNumberInChain = noone;
		
		var sspeed = staggerSpeed == noone ? functionalSpeed : staggerSpeed;
	
		speed = 0;
		var sDir = staggerDirection;
		direction = staggerDirection;
		// stagger twice as quickly early on
		if (staggerFrame > .5*staggerDuration) {
			
			var x1 = x+lengthdir_x(.5*sspeed, sDir);
			var y1 = y+lengthdir_y(.5*sspeed, sDir);
			do {
				x1 = x+lengthdir_x(.5*sspeed, sDir);
				y1 = y+lengthdir_y(.52*sspeed, sDir);
				if place_meeting(x1,y1,obj_solid_parent) || place_meeting(x1,y1,obj_combatant_parent) {
					sDir = (sDir + 45)%360;
				}
			} until ((!place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
			if !place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent) {
				speed = .25*sspeed;
				flinchDirection = sDir;
			}
		} else {
			
			var x1 = x+lengthdir_x(.25*sspeed, sDir);
			var y1 = y+lengthdir_y(.25*sspeed, sDir);
			
			do {
				x1 = x+lengthdir_x(.25*sspeed, sDir);
				y1 = y+lengthdir_y(.25*sspeed, sDir);
				if place_meeting(x1,y1,obj_solid_parent) || place_meeting(x1,y1,obj_combatant_parent) {
					sDir = (sDir + 45)%360;
				}
			} until ((!place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
			if !place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent) {
				speed = .5*sspeed;
				staggerDirection = sDir;
			}
			
		}
		staggerFrame++;
		if (staggerFrame >= staggerDuration) {
			staggerDuration = 0;
			state = CombatantStates.Idle;
			staggerFrame = 0;
			speed = 0;
			staggerSpeed = noone;
		}
		break;
	}
}

// flinching just move you back a little in a given direction
// its like staggering but doesnt interrupt attacks
if isFlinching {
	isStrafing = false;
	if flinchFrame < totalFlinchFrames {
		var fspeed = flinchSpeed == 0 ? functionalSpeed : flinchSpeed;
	
		speed = 0;
		direction = flinchDirection;
		flinchDirection = flinchDirection%360;
		// stagger twice as quickly early on
		var fDir = flinchDirection;
		if (flinchFrame > .5*totalFlinchFrames) {
			
			var x1 = x+lengthdir_x(.25*fspeed, fDir);
			var y1 = y+lengthdir_y(.25*fspeed, fDir);
			do {
				x1 = x+lengthdir_x(.25*fspeed, fDir);
				y1 = y+lengthdir_y(.25*fspeed, fDir);
				if place_meeting(x1,y1,obj_solid_parent) || place_meeting(x1,y1,obj_combatant_parent) {
					fDir = (fDir + 45)%360;
				}
			} until ((!place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent)) || fDir == flinchDirection)
			
			if !place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent) {
				speed = .25*fspeed;
				flinchDirection = fDir;
			}
		} else {
			var x1 = x+lengthdir_x(.5*fspeed, fDir);
			var y1 = y+lengthdir_y(.5*fspeed, fDir);
			
			do {
				x1 = x+lengthdir_x(.25*fspeed, fDir);
				y1 = y+lengthdir_y(.25*fspeed, fDir);
				if place_meeting(x1,y1,obj_solid_parent) || place_meeting(x1,y1,obj_combatant_parent) {
					fDir = (fDir + 45)%360;
				}
			} until ((!place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent)) || fDir == flinchDirection)
			
			if !place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_combatant_parent) {
				speed = .5*fspeed;
				flinchDirection = fDir;
			}
		}
		flinchFrame++;
	} else {
		flinchFrame = 0;
		totalFlinchFrames = 0;
		isFlinching = false;
		flinchSpeed = 0;
	}
}


