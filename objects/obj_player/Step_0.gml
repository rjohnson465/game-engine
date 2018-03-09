event_inherited();
var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading {
	speed = 0;
	state = CombatantStates.Idle;
	path_end();
	exit;
}

if fallFrame < fallTotalFrames {
	// stop preparing attacks
	if ds_map_size(preparingLimbs) != 0 {
		var hand = ds_map_find_first(preparingLimbs);
		for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
			ds_map_replace(prepFrames,hand,-1);
			ds_map_replace(prepFrameTotals,hand,0);
			ds_map_delete(preparingLimbs,hand);
			hand = ds_map_find_next(preparingLimbs,hand);
		}
	}
	// stop attacking
	if ds_map_size(attackingLimbs) != 0 {
		var hand = ds_map_find_first(attackingLimbs);
		for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
			ds_map_delete(attackingLimbs,hand);
			hand = ds_map_find_next(attackingLimbs,hand);
		}
	}
	// stop recovering attacks
	if ds_map_size(recoveringLimbs) != 0 {
		var hand = ds_map_find_first(recoveringLimbs);
		for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
			ds_map_replace(recoveringLimbs,hand,-1);
			ds_map_replace(recoveringLimbs,hand,0);
			ds_map_delete(recoveringLimbs,hand);
			hand = ds_map_find_next(recoveringLimbs,hand);
		}
	}
	isStrafing = false;
	currentUsingSpell = noone;
	attackNumberInChain = noone;
	state = CombatantStates.Idle;
	path_end();
	speed = 0;
	exit;
}

leftHandItem = ds_map_find_value(equippedLimbItems,"l");
rightHandItem = ds_map_find_value(equippedLimbItems,"r");

// lock on logic
var lockOnInputReceived = keyboard_check_released(vk_control);
if gamepad_is_connected(gamePadIndex) {
	lockOnInputReceived = keyboard_check_released(vk_control)
	|| (gamepad_button_check_released(gamePadIndex,gp_stickr) && !isLockedOn);
}
if lockOnInputReceived {
	// always refresh lockOnList (enemies could have left radius or entered
	lockOnList = script_execute(scr_collision_circle_list,x,y,LOCK_ON_DISTANCE,obj_enemy_parent, true, true);
	if (lockOnList == noone) {
		lockOnTarget = noone;
		isLockedOn = false;
	}
	// if already locked on, only look through enemies not yet locked onto
	if (isLockedOn) {
		var closestInstance = noone;
		var foundClosest = false; var i = 1;
		while !foundClosest && i <= ds_list_size(lockOnList) {
			closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, i);
			if ds_list_find_index(lockOnListSeen, closestInstance) == -1 {
				foundClosest = true;
			} else {
				closestInstance = noone;
				i++;
			}
		}
		if closestInstance != noone {
			lockOnTarget = closestInstance;
			ds_list_add(lockOnListSeen, closestInstance);
		} else {
			// we've cycled through all targets; begin cycle again
			ds_list_clear(lockOnListSeen);
			var closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, 1);
			if closestInstance != noone {
				lockOnTarget = closestInstance;
				isLockedOn = true;
				ds_list_add(lockOnListSeen, closestInstance);
			}
		}
	}
	// if not locked on just get the nearest enemy in the list 
	else if (lockOnList != noone){
		var closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, 1);
		if closestInstance != noone {
			lockOnTarget = closestInstance;
			isLockedOn = true;
			ds_list_add(lockOnListSeen, closestInstance);
		}
	}
}
var wallsBetweenLockOnTarget = noone;
if lockOnTarget {
	wallsBetweenLockOnTarget = script_execute(scr_collision_line_list_layer,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
}
// if too far from current lockon target, or esc pressed, or cannot see lockOnTarget no more lock on
var cancelLockOnInputReceived = keyboard_check(vk_escape);
if gamepad_is_connected(gamePadIndex) {
	cancelLockOnInputReceived = keyboard_check(vk_escape) ||
	(gamepad_button_check_released(gamePadIndex,gp_stickr) && !lockOnInputReceived);
}
if	isLockedOn && ((cancelLockOnInputReceived && !global.ui.isShowingMenus) 
	|| distance_to_object(lockOnTarget) > LOCK_ON_DISTANCE
	|| wallsBetweenLockOnTarget != noone ) {
	lockOnTarget = noone;
	isLockedOn = false;
}

// lockOnTarget switching with a controller
if isLockedOn && gamepad_is_connected(gamePadIndex) {
	var h_point = gamepad_axis_value(gamePadIndex, gp_axisrh);
	var v_point = gamepad_axis_value(gamePadIndex, gp_axisrv);
	if ((h_point != 0) || (v_point != 0)) {
		var pdir = point_direction(0, 0, h_point, v_point);
		
		// find all enemies in a given radius 
		var possibleTargets = scr_get_ids_region(lockOnTargetType,x-500,y-500,x+500,y+500);
		
		// pick target that is in sight and closest to pdir (angle-wise, not distance-wise)
		var closestAngleDiff = 180;
		for (var i = 0; i < ds_list_size(possibleTargets); i++) {
			var el = ds_list_find_value(possibleTargets,i);
			var ang = point_direction(lockOnTarget.x,lockOnTarget.y,el.x,el.y);
			var diff = abs(angle_difference(pdir,ang));
			
			var wallsBetweenLockOnTarget = script_execute(scr_collision_line_list_layer,x,y,el.x,el.y,obj_wall_parent,true,true);
			if diff < closestAngleDiff && diff < 90 && wallsBetweenLockOnTarget == noone {
				lockOnTarget = el;
			}
		}
		
	}
}

// move state triggers
var UP = keyboard_check(ord("W"));
var DOWN = keyboard_check(ord("S"));
var LEFT = keyboard_check(ord("A"));
var RIGHT = keyboard_check(ord("D"));
var SHIFT = keyboard_check(vk_shift) || gamepad_button_check(gamePadIndex, gp_stickl);
var GAMEPADHMOVE = false;
var GAMEPADVMOVE = false;
if gamepad_is_connected(gamePadIndex) {
	GAMEPADHMOVE = gamepad_axis_value(gamePadIndex, gp_axislh) != 0;
	GAMEPADVMOVE = gamepad_axis_value(gamePadIndex, gp_axislv) != 0;
}
var isMoveInputReceived = UP || DOWN || LEFT || RIGHT || GAMEPADHMOVE || GAMEPADVMOVE;

if isMoveInputReceived && state != CombatantStates.Attacking && state != CombatantStates.Staggering && state != CombatantStates.Dodging {
	state = CombatantStates.Moving;
}
if !isMoveInputReceived && state == CombatantStates.Moving {
	state = CombatantStates.Idle;
}

if state != CombatantStates.Staggering && !isMouseInMenu {
	// player faces mouse if not locked on
	if state == CombatantStates.Idle || state == CombatantStates.Moving 
	|| (ds_map_size(preparingLimbs)!=0)
	{
		if gamepad_is_connected(gamePadIndex) {
			var h_point = gamepad_axis_value(gamePadIndex, gp_axisrh);
			var v_point = gamepad_axis_value(gamePadIndex, gp_axisrv);
			if ((h_point != 0) || (v_point != 0))
			{
				var pdir = point_direction(0, 0, h_point, v_point);
				var dif = angle_difference(pdir, facingDirection);
				facingDirection += median(-45, dif, 45);
				facingDirection = (facingDirection+360)%360;
			}
		} else {
			var pdir = point_direction(x,y,mouse_x,mouse_y);
			var dif = angle_difference(pdir, facingDirection);
			facingDirection += median(-45, dif, 45);
			facingDirection = (facingDirection+360)%360;
		}
	}
	// otherwise, player always faces locked on enemy
	if isLockedOn {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	}
}

// state machine overrides
switch(state) {
	case CombatantStates.Idle: {
		if isFlinching exit;
		speed = 0;
		break;
	}
	case CombatantStates.Moving: {
		if isFlinching {
			break;
		}
		speed = 0;
		var canMove = false;
		var gamePadInputReceived = false;
		if gamepad_is_connected(gamePadIndex) {
			var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
			var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
			if h_point != 0 || v_point != 0 {
				gamePadInputReceived = true;
				direction = (point_direction(0,0,h_point,v_point))%360;
			}
		} else {
			var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
			if UP && RIGHT {
				direction = 45;
			}
			else if UP && LEFT  {
				direction = 135;
			}
			else if DOWN && LEFT {
				direction = 225;
			}
			else if DOWN && RIGHT {
				direction = 315;
			}
			else if RIGHT {
				direction = 0;
			}
			else if LEFT {
				direction = 180;
			}
			else if UP {
				direction = 90;
			}
			else if DOWN {
				direction = 270;
			}
		}
		
		if (UP || DOWN || LEFT || RIGHT || gamePadInputReceived) {
			var useSpeed = functionalSpeed;
			if SHIFT && stamina > 0 {
				useSpeed = functionalSpeed*1.25;
				stamina -= .35;
			}
			// walking backwards is slow
			dirDiff = abs(direction - facingDirection);
			if dirDiff > 135 && dirDiff < 225  {
				moveToNearestFreePoint(direction,.5*useSpeed);
			}	
			else {
				moveToNearestFreePoint(direction,useSpeed);
			}
		}	
		
		break;
	}
	case CombatantStates.Attacking: {
		
		if !isFlinching {
			speed = 0;
		
			var canMove = false;
			var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
			var gamePadInputReceived = false;
			if gamepad_is_connected(gamePadIndex) {
				var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
				var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
				if h_point != 0 || v_point != 0 {
					gamePadInputReceived = true;
					direction = (point_direction(0,0,h_point,v_point))%360;
				}
			} else {
				if UP && RIGHT && !place_meeting_layer(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
					direction = 45;
				}
				else if UP && LEFT && !place_meeting_layer(x-usingSpeed, y-usingSpeed, obj_solid_parent) {
					direction = 135;
				}
				else if DOWN && LEFT && !place_meeting_layer(x-usingSpeed, y+usingSpeed, obj_solid_parent) {
					direction = 225;
				}
				else if DOWN && RIGHT && !place_meeting_layer(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
					direction = 315;
				}
				else if RIGHT && !place_meeting_layer(x+usingSpeed, y, obj_solid_parent) {
					direction = 0;
				}
				else if LEFT && !place_meeting_layer(x-usingSpeed, y, obj_solid_parent) {
					direction = 180;
				}
				else if UP && !place_meeting_layer(x, y-usingSpeed, obj_solid_parent) {
					direction = 90;
				}
				else if DOWN && !place_meeting_layer(x, y+usingSpeed, obj_solid_parent) {
					direction = 270;
				}
			}
		
		
			var x1 = x +lengthdir_x(usingSpeed,direction);
			var y1 = y +lengthdir_y(usingSpeed,direction);
			canMove = !place_meeting_layer(x1,y1,obj_solid_parent);

			if !canMove {
				speed = 0;
			}
		
			if (UP || DOWN || LEFT || RIGHT || gamePadInputReceived) && canMove {
				// walking backwards is slow
				dirDiff = abs(direction - facingDirection)
				if dirDiff > 135 && dirDiff < 225  {
					speed = .25*functionalSpeed;
				}	
				else speed = .5*functionalSpeed;
			}	
			// run
			if SHIFT && stamina > 0 && canMove {
				speed = .5*(speed*1.25);
				stamina -= .5;
			}
		}
		
		// check if spell attack
		// spells are all 2h and thus use the "r" side (might change this later idk)
		if currentUsingSpell != noone {
			
			speed = .5*speed;
			var currentSpell = ds_map_find_value(knownSpells,currentUsingSpell);
			var MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle);
			if gamepad_is_connected(gamePadIndex) {
				MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle) || 
				gamepad_button_check_released(gamePadIndex,gp_shoulderlb);
			}
			
			if ds_map_size(attackingLimbs) == 0 && ds_map_size(preparingLimbs) == 0 && ds_map_size(recoveringLimbs) == 0 {
				ds_map_replace(prepFrameTotals,"l",currentSpell.castFrames);
				ds_map_replace(prepFrames,"l",0);
				ds_map_replace(preparingLimbs,"l",1);
			}
			
			// attack sequence 
			if ds_map_find_value(prepFrames,"l") >= ds_map_find_value(prepFrameTotals,"l") || MIDDLE_BUTTON_RELEASED {
				cursor_sprite = -1;
				var prepFrame = ds_map_find_value(prepFrames,"l");
				var prepFrameTotal = ds_map_find_value(prepFrameTotals,"l");
				var percentCharged = prepFrame / prepFrameTotal;
				
				var chargeCost = round(percentCharged*currentSpell.maxChargeCost);
				// subtract charges from right hand item first
				if rightHandItem.charges > 0 {
					rightHandItem.charges -= chargeCost;
					if rightHandItem.charges < 0 {
						rightHandItem.charges = 0;
					}
				} else {
					leftHandItem.charges -= chargeCost;
					if leftHandItem.charges < 0 {
						leftHandItem.charges = 0;
					}
				}
				
				// only cast spell if charged enough to cost at least one magic charge
				if chargeCost > 0 {
					stamina -= percentCharged*currentSpell.staminaCost;
					for (var i = 0; i < currentSpell.numberOfProjectiles; i++) {
						global.owner = id;
						global.projectileNumber = i+1;
						global.percentCharged = percentCharged;
						global.limbKey = "l";
						//global.spellAttunement = spellAttunement;
						instance_create_depth(x,y,1,obj_attack);	
					}
				}
				ds_map_replace(prepFrames,"l",-1);
				ds_map_replace(prepFrameTotals,"l",0);
				ds_map_delete(preparingLimbs,"l");
				currentUsingSpell = noone;
				state = CombatantStates.Idle;
			} else {
				ds_map_replace(prepFrames,"l",ds_map_find_value(prepFrames,"l")+1);
			}
			break;
			
		}
		
		// melee / ranged
		var LEFTRELEASED = mouse_check_button_pressed(mb_left);
		if gamepad_is_connected(gamePadIndex) {
			LEFTRELEASED = mouse_check_button_pressed(mb_left) 
			|| gamepad_button_check_pressed(gamePadIndex,gp_shoulderl);
		}
		var RIGHTRELEASED = mouse_check_button_pressed(mb_right);
		if gamepad_is_connected(gamePadIndex) {
			RIGHTRELEASED = mouse_check_button_pressed(mb_left) 
			|| gamepad_button_check_released(gamePadIndex,gp_shoulderr);
		}
		
		// iterate over preparing hands 
		// if they just started preparing, need to assign prepare frames / total frames
		// if they are finishing preparing, need to create attack objects
		if ds_map_size(preparingLimbs) != 0 {
			var hand = ds_map_find_first(preparingLimbs);
			for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
				var weapon = hand == "l" ? leftHandItem : rightHandItem;
				var attackInChain = ds_map_find_value(preparingLimbs,hand);
				
				var prepFrame = ds_map_find_value(prepFrames,hand);
				var prepFrameTotal = ds_map_find_value(prepFrameTotals,hand);
				
				// check if this hand just started preparing attack
				if prepFrame == -1 {
					ds_map_replace(prepFrames,hand,0);
					var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
					var prepSprite = asset_get_index("spr_player_"+itemSprite+"_prep_"+string(attackInChain));
					ds_map_replace(prepFrameTotals,hand,sprite_get_number(prepSprite));
				}
				// if at the end of attack preparation, we need to create an attack object (slightly different process for ranged vs melee) 
				else if prepFrame >= prepFrameTotal-1 {
					if ( !(weapon.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded)) {
						speed = 0;
						ds_map_replace(prepFrames,hand,-1);
						ds_map_replace(prepFrameTotals,hand,0);
						ds_map_delete(preparingLimbs,hand);
						ds_map_replace(attackingLimbs,hand,attackInChain);
						stamina -= weapon.staminaCostArray[attackInChain-1];
						global.owner = id;
						global.limbKey = hand;
						instance_create_depth(x,y,1,obj_attack);
					}
					else {
						ds_map_replace(prepFrames,hand,prepFrame-1);
						isReadyToFire = true;
					}
				} 
				
				// if preparing an attack and no attacks are happening with other hand, move back a bit (if you can)
				if ds_map_size(attackingLimbs) == 0 {
					var x1 = x +lengthdir_x(-.5,facingDirection);
					var y1 = y +lengthdir_y(-.5,facingDirection);
		
					if weapon.subType == HandItemTypes.Melee && !place_meeting_layer(x1, y1, obj_solid_parent){
						direction = facingDirection;
						speed = -.5;
					}
				} else {
					speed = 0;
				}
				hand = ds_map_find_next(preparingLimbs,hand);
			}
		}
		
		// update attackFrames values
		if ds_map_size(attackingLimbs) != 0 {
			var hand = ds_map_find_first(attackingLimbs);
			for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
				var idd = id;
				var attackObj = noone;
				with obj_attack {
					if owner = idd && limbKey == hand {
						attackObj = id;
					}
				}
				if attackObj != noone {
					ds_map_replace(attackFrames,hand,attackObj.image_index);
				}
				hand = ds_map_find_next(attackingLimbs, hand);
			}
		}
		
		// iterate over recovering hands
		// if they just started recovering, need to assign recover frames / total frames
		// if they just finished recovering, need to check if we need to leave attack state or if we need to attack with that hand again
		if ds_map_size(recoveringLimbs) != 0 {
			var hand = ds_map_find_first(recoveringLimbs);
			for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
				var weapon = hand == "l" ? leftHandItem : rightHandItem;
				var attackInChain = ds_map_find_value(recoveringLimbs,hand);
				var recoverFrame = ds_map_find_value(recoverFrames,hand);
				var recoverFrameTotal = ds_map_find_value(recoverFrameTotals,hand);
				
				// check if this hand just started recovering attack
				if recoverFrame == -1 {
					ds_map_replace(recoverFrames,hand,0);
					var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
					var recoverSprite = asset_get_index("spr_player_"+itemSprite+"_recover_"+string(attackInChain));
					ds_map_replace(recoverFrameTotals,hand,sprite_get_number(recoverSprite));
				}
				// if at end of recover, we may need to leave attack state (if no other hands are recovering or preparing or attacking)
				else if recoverFrame >= recoverFrameTotal-1 {
					// no matter what, we need to remove this hand from recoveringLimbs and reset frame values
					ds_map_replace(recoverFrames,hand,-1);
					ds_map_replace(recoverFrameTotals,hand,0);
					ds_map_delete(recoveringLimbs,hand);
					ds_map_replace(attackAgain,hand,false);
					
					if ds_map_size(preparingLimbs) == 0 && ds_map_size(attackingLimbs) == 0 && ds_map_size(recoveringLimbs) == 0 {
						state = CombatantStates.Idle;
						break;
					} 
				} else {
					// if we're in recover but told to attack again:
					// make sure there is another attack in the chain
					// decrement recover frames until at 0
					// then create new preparingLimb / prepFrames
					var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
					var prepString = "spr_"+spriteString+"_"+itemSprite+"_prep_"+string(attackInChain+1);
					if ds_map_find_value(attackAgain,hand) != 0 && asset_get_index(prepString) != -1 {
						
						if recoverFrame == 0 {
							ds_map_replace(preparingLimbs,hand,attackInChain+1);
							ds_map_delete(recoveringLimbs,hand);
							ds_map_replace(recoverFrames,hand,-1);
							ds_map_replace(recoverFrameTotals,hand,0);
							ds_map_replace(attackAgain,hand,false);
						} else {
							ds_map_replace(recoverFrames,hand,recoverFrame-1);
						}
						break;
					}
					
					ds_map_replace(recoverFrames,hand,recoverFrame+1);
				}
				hand = ds_map_find_next(recoveringLimbs,hand);
			}
		}
		
		// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
		if ds_map_size(attackingLimbs) != 0 {
			var attackingMelee = 
				(ds_map_find_value(attackingLimbs,"l") && leftHandItem.subType == HandItemTypes.Melee)	||
				(ds_map_find_value(attackingLimbs,"r") && rightHandItem.subType == HandItemTypes.Melee)
			if ds_map_size(preparingLimbs) == 0 {
				x1 = x + lengthdir_x(2,facingDirection);
				y1 = y + lengthdir_y(2,facingDirection);

				if attackingMelee && !(place_meeting_layer(x1,y1,obj_solid_parent)) {
					direction = facingDirection;
					speed = 1;
				} else {
					speed = 0;
				}
			} else {
				speed = 0;
			}
		}
		
		// this is a 2h ranged weapon, so limb must be "l"
		if isReadyToFire && RIGHTRELEASED && stamina > 0 {
			speed = 0;
			var attackInChain = ds_map_find_value(preparingLimbs,"l"); // pretty sure this is always gonna be 1
			ds_map_replace(prepFrames,"l",-1);
			ds_map_replace(prepFrameTotals,"l",0);
			isReadyToFire = false;
			ds_map_replace(attackingLimbs,"l",attackInChain);
			stamina -= leftHandItem.staminaCostArray[attackInChain-1];
			ds_map_delete(preparingLimbs,"l");
			global.owner = id;
			global.limbKey = "l";
			instance_create_depth(x,y,1,obj_attack);
		}
		break;
	}
}





