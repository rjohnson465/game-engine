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
if stamina < maxStamina {
	// stamina regens slower if shielding
	if isShielding {
		stamina += (.5*staminaRegen)/30;
	}
	else stamina += staminaRegen/30;
}
if hp < maxHp {
	hp += hpRegen/30;
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
		isSlowed = false;
		isFrozen = true;
	} else if conditionPercent > 95 {
		ds_map_replace(conditionLevels,currentCondition,1);
		switch currentCondition {
			case POISON: {
				isPoisoned = true; break;
			}
			case FIRE: {
				// if burn applied on a slowed or frozen target, slow / frozen is removed
				if !isBurning && (isSlowed || isFrozen) {
					ds_map_replace(conditionPercentages,ICE,0);
					isSlowed = false;
					isFrozen = false;
				}
				isBurning = true; break;
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
				isBurning = false; burnDamage = 0; break;
			}
			case ICE: {
				isSlowed = false; isFrozen = false; break;
			}
			case POISON: {
				isPoisoned = false; poisonDamage = 0; break;
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
	// TODO this might get ridiculous is someone has a shitzillion different particles all over them
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
					// is this needed? defense was already accounted for when burnDamage was set first, right?
					//burnDamage = defense >= 0 ? (burnDamage - burnDamage*(defense/100)) : (burnDamage + burnDamage*(defense/100));
					var originalBurnDamage = burnDamage;
					if burnDamage > hp {
						burnDamage = hp;
					}
					hp -= burnDamage;
					if type != CombatantTypes.Player {
						global.damageAmount = burnDamage;
						global.victim = id;
						instance_create_depth(x,y,1,obj_damage);
					}
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
					
					if type != CombatantTypes.Player {
						global.damageAmount = poisonDamage;
						global.victim = id;
						instance_create_depth(x,y,1,obj_damage);
					}
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
				if meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange {
					state = CombatantStates.AggroMelee;
					break;
				}
				// if not, check if in ranged aggro range
				else if rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
					state = CombatantStates.AggroRanged;
					break;
				}
				else if isNoticingEngagement || wasJustHit {
					wasJustHit = false;
					// first try ranged
					if rangedAttacksCount > 0 {
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
			currentMeleeAttack = round(random_range(1,meleeAttacksCount));
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
			currentRangedAttack = round(random_range(1,rangedAttacksCount));
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
				if currentMeleeAttack && distance_to_object(lockOnTarget) > meleeAggroRange && rangedAttacksCount > 0 {
					state = CombatantStates.AggroRanged;
					break;
				}
				// vice versa
				else if currentRangedAttack && distance_to_object(lockOnTarget) < meleeAggroRange && meleeAttacksCount > 0 {
					state = CombatantStates.AggroMelee;
					break;
				}
			
				// CHECK 3: WILL WE DODGE IN THIS MOVE STATE?
				
				// if we've not yet calculated if we'll dodge during this Move state, calculate that now
				// this is calculated only once per move state
				if !hasCalculatedWillDodge {
					randomize();
					var rand = random_range(1,100);
					willDodge = rand <= agility ? true : false;
					hasCalculatedWillDodge = true;
				}
			
				// If we're close to our lockOnTarget and they're preparing attack and we've decided to dodge during this Move state,
				// decide exactly what frame in the lockOnTarget's attack prep to dodge on
				// is this is shit for ranged attacks?
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
				var attackObj = instance_nearest(x,y,obj_attack_parent);
				var range = 45; // the range at which to start attempting dodge. default is 45 pixels.
				// if dodging a player's melee attack, range is based on the melee weapon the player is using
				if lockOnTarget.type == CombatantTypes.Player && isMeleeAttack {
					var weapon = lockOnTarget.currentAttackingHand == "l" ? lockOnTarget.leftHandItem : lockOnTarget.rightHandItem;
					if weapon.range != 0 {
						range = weapon.range;
					}
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
				else if distance_to_object(obj_attack_parent) < 200 - agility && script_execute(scr_is_facing,id,attackObj) && willDodge {
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
				if pred && !isStrafing && !isFlinching {
					if wallsBetweenTarget == noone {
						facingDirection = point_direction(x,y,global.player.x,global.player.y);
					} else {
						facingDirection = direction;
					}
			
					// calculate grid path to lockOnTarget and move to it
					var p = mp_grid_path(personalGrid, path,x,y,lockOnTarget.x,lockOnTarget.y,1);
					if	p
					{
						path_start(path,functionalSpeed,path_action_stop, false);
						break;
					}
				}
				// within range for attack
				else {
					path_end();
					hasCalculatedWillDodge = false;
					stupidityFrame = 100 - aggressiveness;
					
					if attackFrequencyFrame == -1 {
						randomize();
						attackFrequencyFrame = round(random_range(attackFrequencyTotalFrames[0],attackFrequencyTotalFrames[1]));
					} else if attackFrequencyFrame == 0 {
						// check if should enter attack state every x frames (some number between ranges specified in attackFrequencyTotalFrames)
						// TODO Devin math major
						randomize();
						var rand = random_range(1,100);
						if rand <= aggressiveness {
							if !isFrozen {
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
								if rand <= 50 {
									isStrafing = true;
									strafeAngle = point_direction(lockOnTarget.x,lockOnTarget.y,x,y);
								} else isStrafing = false;
							} else {
								if isStrafing {
									facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
									/*strafeAngle += functionalSpeed;
									randomize();
									var rand = random_range(30,50);
									var dist = meleeRangeArray[currentMeleeAttack-1];
									var xx = lockOnTarget.x + lengthdir_x(dist, strafeAngle);
									var yy = lockOnTarget.y + lengthdir_y(dist, strafeAngle);

									var dir = point_direction(x,y,xx,yy);
									if !position_meeting(x+lengthdir_x(functionalSpeed,dir),y+lengthdir_y(functionalSpeed,dir),lockOnTarget) {
										x = x+lengthdir_x(functionalSpeed,dir);
										y = y+lengthdir_y(functionalSpeed,dir);
									}*/

									if distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack-1] {
										strafeFrame = -1;
										isStrafing = false;
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
				var a = meleeAttacksHands[attackNumber-1];
				var aVal = a[0];
				switch aVal {
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
			
			// aim while preparing attack
			facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			
			if !isRanged && ds_map_size(preparingHands) !=0 {
				// it's posslbe we're out of range again, especially if the lockOnTarget staggered or ran. try getting in range again
				if distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack-1] {
					mp_potential_step(lockOnTarget.x,lockOnTarget.y,functionalSpeed*1.5,true);
				}
			}
		
			// if idle or recovering, attack or perform next attack in chain (if aggressiveness allows)
			// TODO refactor this to support combatants without conventional l/r hands
			var aa = ds_map_find_value(recoveringHands,prevAttackHand);
			if attackNumberInChain == noone || ds_map_find_value(recoveringHands,prevAttackHand) == attackNumberInChain {

				// decide if we should attack (maybe again, if there's another attack in the chain)
				var willAttack = false;
				var a = !isRanged ? meleeAttacksSpriteChain[attackNumber-1] : rangedAttacksSpriteChain[attackNumber-1];
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
					if hasHands && !isRanged {
						var a = meleeAttacksHands[attackNumber-1];
						var aVal = a[attackNumberInChain - 1];
						var handSide = noone;
						switch aVal {
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
						//currentAttackingHand = a[attackNumberInChain - 1];
						var currentAttackingHand = handSide; // TODO this fucks up every now and then
					}
					// for now, ranged is always 2h and always in the right hand
					if hasHands && isRanged {
						currentAttackingHand = "r";
					}
					
					// get the sprite for the attack prep based on the spriteChain defined for this attack number
					var chainArray = meleeAttacksSpriteChain[attackNumber-1];
					var specificAttackArray = chainArray[attackNumberInChain-1];
					var itemSprite = specificAttackArray[0];
					var spriteNum1 = specificAttackArray[1];
					var spriteNum2 = specificAttackArray[2];
					
					// start attack prep
					var prepSprite = asset_get_index("spr_"+spriteString+"_"+itemSprite+"_prep_"+string(spriteNum1)+"_"+string(spriteNum2));
					if ds_map_find_value(preparingHands,currentAttackingHand) == undefined {
						ds_map_add(preparingHands,currentAttackingHand,spriteNum2);
					} else ds_map_replace(preparingHands,currentAttackingHand,spriteNum2);
					ds_map_replace(prepFrameTotals,currentAttackingHand,sprite_get_number(prepSprite));
					ds_map_replace(prepFrames,currentAttackingHand,0);
					
					// if this same hand was recovering before, stop that
					if ds_map_find_value(recoveringHands,currentAttackingHand) != undefined {
						ds_map_delete(recoveringHands,currentAttackingHand);
						ds_map_replace(recoverFrames,currentAttackingHand,-1);
						ds_map_replace(recoverFrameTotals,currentAttackingHand,0);
					}

				} 
				else {
					
					// loop through recoverFrames -- if a hand is at recoverFrame 0, that means it is beginning to recover
					var currentRecoverFrames = ds_map_find_first(recoverFrames);
					for (var i = 0; i < ds_map_size(recoverFrames); i++) {
						
						if ds_map_find_value(recoverFrames,currentRecoverFrames) == 0 {
							
							// the attack number in chain of the hand that was prepaing (but is about to be recovering)
							var numInChain = ds_map_find_value(attackingHands,currentRecoverFrames);
							ds_map_delete(attackingHands,currentRecoverFrames);
						
							// get the sprite for the attack recovery based on the spriteChain defined for this attack number
							var chainArray = meleeAttacksSpriteChain[attackNumber-1];
							var specificAttackArray = chainArray[numInChain-1];
							var itemSprite = specificAttackArray[0];
							var spriteNum1 = specificAttackArray[1];
							var spriteNum2 = specificAttackArray[2];
					
							var recoverSprite = asset_get_index("spr_"+spriteString+"_"+itemSprite+"_recover_"+string(attackNumber)+"_"+string(numInChain));
							
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
						if attackInChain == 2 {
							var b = 3;
						}
						stamina -= currentAttackingHandItem.staminaCostArray[attackInChain-1];
						ds_map_delete(preparingHands,currentPrepFrames);
						ds_map_replace(attackingHands,currentPrepFrames,attackInChain);
					}
					// this might be faintly retarded
					global.owner = id; // passed as param to attackObj
					global.handSide = currentPrepFrames;
					var attackObj = instance_create_depth(x,y,1,obj_attack_parent);
				}
				currentPrepFrames = ds_map_find_next(prepFrames,currentPrepFrames);
			}
			
			// attack animation frame logic shit is in enemy phys attack obj
			
			// iterate over the recover frames for left and right hands to see if an attack is ended
			var currentRecoverFrames = ds_map_find_first(recoverFrames);
			for (var i = 0; i < ds_map_size(recoverFrames); i++) {
				var recoverFrame = ds_map_find_value(recoverFrames,currentRecoverFrames);
				var totalRecoverFrames = ds_map_find_value(recoverFrameTotals,currentRecoverFrames);
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
		if dodgeFrame >= totalDodgeFrames - 1 {
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
		currentAttackingHand = noone;
		currentUsingSpell = noone;
		attackNumberInChain = noone;
		
		var sspeed = staggerSpeed == noone ? functionalSpeed : staggerSpeed;
	
		speed = 0;
		direction = staggerDirection;
		// stagger twice as quickly early on
		if (staggerFrame > .5*staggerDuration) {
			var x1 = x+lengthdir_x(.25*sspeed, staggerDirection);
			var y1 = y+lengthdir_y(.25*sspeed, staggerDirection);
			if !place_meeting(x1,y1,obj_solid_parent) {
				speed = .25*sspeed;
			} else staggerDirection += 45;
		} else {
			var x1 = x+lengthdir_x(.5*sspeed, staggerDirection);
			var y1 = y+lengthdir_y(.5*sspeed, staggerDirection);
			if !place_meeting(x1,y1,obj_solid_parent) {
				speed = .5*sspeed;
			} else staggerDirection += 45;
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

// SHIELDING STUFF

// if has a shield, every totalShieldingFrames, decide if should shield (based on cautiousness + some luck)
// this does not affect Player
if hasHands && type != CombatantTypes.Player {
	if	leftHandItem.type == HandItemTypes.Shield 
		&& state == CombatantStates.Moving 
		&& !isShielding
		&& stamina > 0
		{
		if shieldingFrame >= totalShieldingFrames {
			randomize();
			rand = random_range(1,100)
			// if close to player, chance to shield increases 
			if rand <= cautiousness {
				global.owner = id;
				instance_create_depth(x,y,1,obj_shield_parent);
				isShielding = true;
				shieldingFrame = 0;
			} 
			
		} else {
				shieldingFrame++;
		}
	}
	// hold up the shield for a certain amount of time, based on cautiousness and luck
	if	leftHandItem.type == HandItemTypes.Shield
		&& state == CombatantStates.Moving
		&& isShielding {
			if shieldingFrame >= totalShieldingFrames {
				isShielding = false;
				shieldingFrame = 0;
			} else {
				var num;
				randomize();
				var rand = random_range(5,10);
				rand -= (cautiousness/10);
				num = rand;
				if !lockOnTarget.isPreparingAttack {
					shieldingFrame += num;
				}
			}
		}
}

// flinching just move you back a little in a given direction
// its like staggering but doesnt interrupt attacks
if isFlinching {
	if flinchFrame < totalFlinchFrames {
		
		var fspeed = flinchSpeed == noone ? functionalSpeed : flinchSpeed;
	
		//speed = 0;
		direction = flinchDirection;
		// stagger twice as quickly early on
		if (flinchFrame > .5*totalFlinchFrames) {
			var x1 = x+lengthdir_x(.25*fspeed, flinchDirection);
			var y1 = y+lengthdir_y(.25*fspeed, flinchDirection);
			if !place_meeting(x1,y1,obj_solid_parent) {
				speed = .25*fspeed;
			} else flinchDirection += 45;
		} else {
			var x1 = x+lengthdir_x(.5*fspeed, flinchDirection);
			var y1 = y+lengthdir_y(.5*fspeed, flinchDirection);
			if !place_meeting(x1,y1,obj_solid_parent) {
				speed = .5*fspeed;
			} else flinchDirection += 45;
		}
		flinchFrame++;
	} else {
		flinchFrame = 0;
		totalFlinchFrames = 0;
		isFlinching = false;
	}
}


