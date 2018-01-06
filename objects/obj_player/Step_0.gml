event_inherited();
// lock on logic
if (keyboard_check_released(vk_control)) {
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
	wallsBetweenLockOnTarget = script_execute(scr_collision_line_list,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
}
// if too far from current lockon target, or esc pressed, or cannot see lockOnTarget no more lock on
if	isLockedOn && ((keyboard_check(vk_escape) && !global.ui.isShowingMenus) 
	|| distance_to_object(lockOnTarget) > LOCK_ON_DISTANCE
	|| wallsBetweenLockOnTarget != noone ) {
	lockOnTarget = noone;
	isLockedOn = false;
}

// move state triggers
var UP = keyboard_check(ord("W"));
var DOWN = keyboard_check(ord("S"));
var LEFT = keyboard_check(ord("A"));
var RIGHT = keyboard_check(ord("D"));
var SHIFT = keyboard_check(vk_shift);
var isMoveInputReceived = UP || DOWN || LEFT || RIGHT;

if isMoveInputReceived && state != CombatantStates.Attacking && state != CombatantStates.Staggering && state != CombatantStates.Dodging {
	state = CombatantStates.Moving;
}
if !isMoveInputReceived && state == CombatantStates.Moving {
	state = CombatantStates.Idle;
}

if state != CombatantStates.Staggering && !isAttacking && !isRecovering && !isMouseInMenu {
	// player faces mouse if not locked on
	facingDirection = point_direction(x,y,mouse_x,mouse_y);
	// otherwise, player always faces locked on enemy
	if isLockedOn {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	}
}

// state machine overrides
switch(state) {
	case CombatantStates.Idle: {
		speed = 0;
		break;
	}
	case CombatantStates.Moving: {
		speed = 0;
		var canMove = false;
		var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
		if UP && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 45;
		}
		else if UP && LEFT && !place_meeting(x-usingSpeed, y-usingSpeed, obj_solid_parent) {
			direction = 135;
		}
		else if DOWN && LEFT && !place_meeting(x-usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 225;
		}
		else if DOWN && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 315;
		}
		else if RIGHT && !place_meeting(x+usingSpeed, y, obj_solid_parent) {
			direction = 0;
		}
		else if LEFT && !place_meeting(x-usingSpeed, y, obj_solid_parent) {
			direction = 180;
		}
		else if UP && !place_meeting(x, y-usingSpeed, obj_solid_parent) {
			direction = 90;
		}
		else if DOWN && !place_meeting(x, y+usingSpeed, obj_solid_parent) {
			direction = 270;
		}
		
		
		var x1 = x +lengthdir_x(usingSpeed,direction);
		var y1 = y +lengthdir_y(usingSpeed,direction);
		canMove = !place_meeting(x1,y1,obj_solid_parent);

		if !canMove {
			state = CombatantStates.Idle;
			break;
		}
		
		if (UP || DOWN || LEFT || RIGHT) && canMove {
			// walking backwards is slow
			dirDiff = abs(direction - facingDirection)
			if dirDiff > 135 && dirDiff < 225  {
				speed = .5*functionalSpeed;
			}	
			else speed = functionalSpeed;
		}	
		// run
		if SHIFT && stamina > 0 && canMove {
			speed = speed*1.25;
			stamina -= .5;
		}
		break;
	}
	case CombatantStates.Attacking: {
		
		// check if spell attack
		if currentUsingSpell != noone {
			if currentUsingSpell == "aoe" {
				cursor_sprite = spr_lockon;
				var wallsBetweenTarget = script_execute(scr_collision_line_list,x,y,mouse_x,mouse_y,obj_wall_parent,true,true);
				// do not alow aoe spell to be cast beyond walls 
				if wallsBetweenTarget != noone {
					cursor_sprite = -1;
					prepAnimationFrame = -1;
					prepAnimationTotalFrames = 0;
					isPreparingAttack = false;
					currentUsingSpell = noone;
					state = CombatantStates.Idle;
					break;
				}
				
			}
			speed = 0;
			var currentSpell = ds_map_find_value(knownSpells,currentUsingSpell);
			var MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle);
			
			if !isAttacking && !isPreparingAttack && !isRecovering {		
				//var prepSprite = asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain));
				prepAnimationTotalFrames = currentSpell.castFrames;
				prepAnimationFrame = 0;
				isPreparingAttack = true;
			}
			
			// attack sequence 
			if	prepAnimationFrame >= prepAnimationTotalFrames || MIDDLE_BUTTON_RELEASED {
				cursor_sprite = -1;
				var percentCharged = prepAnimationFrame / prepAnimationTotalFrames;
				
				var chargeCost = round(percentCharged*currentSpell.maxChargeCost);
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
						if currentUsingSpell != "aoe" {
							instance_create_depth(x,y,1,obj_attack_parent);	
						} else {
							instance_create_depth(mouse_x,mouse_y,1,obj_attack_parent);	
						}
					}
				}
				prepAnimationFrame = -1;
				prepAnimationTotalFrames = 0;
				isPreparingAttack = false;
				currentUsingSpell = noone;
				state = CombatantStates.Idle;
			}
			break;
			
		}
		
		// melee / ranged
		var currentAttackingHandItem = currentAttackingHand == "l" ? leftHandItem : rightHandItem;
		var attackType = currentAttackingHandItem.type;
		var weaponString = currentAttackingHandItem.spriteName;
		// melee (maybe also ranged idk TODO)
		if !isAttacking && !isPreparingAttack && !isRecovering {		
			var prepSprite = asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain));
			prepAnimationTotalFrames = sprite_get_number(prepSprite);
			prepAnimationFrame = 0;
			isPreparingAttack = true;
		}
		
		var LEFTRELEASED = mouse_check_button_pressed(mb_left);
		var RIGHTRELEASED = mouse_check_button_pressed(mb_right);
					
		// if attacking or preparing to attack and the user clicks again, we gonna attack again after this attack (if another attack in chain exists)
		if isAttacking || isPreparingAttack || isRecovering {
		
			if LEFTRELEASED || RIGHTRELEASED {
				attackAgain = true;
				attackAgainSameSide = (LEFTRELEASED && currentAttackingHand == "l") || 
									(RIGHTRELEASED && currentAttackingHand == "r") ? true: false;
			}
		}
		
		// if recovering but mouse button was clicked during last attack/prep phase, attack again
		if isRecovering && attackAgain {
			var nonAttackingHandItem = currentAttackingHand == "l" ? rightHandItem : leftHandItem;
			if 
				asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain+1)) != -1
				&& stamina > 0 
				&& attackAgainSameSide 
				{
					isRecovering = false;
					global.playerAttackNumberInChain += 1;
					var prepSprite = asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain));
					prepAnimationTotalFrames = sprite_get_number(prepSprite);
					prepAnimationFrame = 0;
					isPreparingAttack = true;
					attackAgain = false;
					break;
				}  
				else if 
					stamina > 0 
					&& !attackAgainSameSide
					&& nonAttackingHandItem.type != HandItemTypes.Shield
					&& !currentAttackingHandItem.isTwoHanded
				{
					isRecovering = false;
					currentAttackingHand = currentAttackingHand == "l" ? "r" : "l";
					global.playerAttackNumberInChain = 1;
					var prepSprite = asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain));
					prepAnimationTotalFrames = sprite_get_number(prepSprite);
					prepAnimationFrame = 0;
					isPreparingAttack = true;
					attackAgain = false;
					break;
				}
		}
		
		speed = 0;
		// move back a bit while prepping melee attack, if not going to hit solid object
		var x1 = x +lengthdir_x(-.5,facingDirection);
		var y1 = y +lengthdir_y(-.5,facingDirection);
		
		if isPreparingAttack && currentAttackingHandItem.type == HandItemTypes.Melee && !place_meeting(x1, y1, obj_solid_parent){
			direction = facingDirection;
			speed = -.5;
		}

		// move forward a bit while delivering melee attack, if not going to hit solid object
		x1 = x + lengthdir_x(2,facingDirection);
		y1 = y + lengthdir_y(2,facingDirection);
		if isAttacking && currentAttackingHandItem.type == HandItemTypes.Melee && !(place_meeting(x1,y1,obj_solid_parent)) {
			direction = facingDirection;
			speed = 2;
		}
		
		// basic attack sequence 
		if	prepAnimationFrame >= prepAnimationTotalFrames
			{
			if ( !(attackType == HandItemTypes.Ranged && rightHandItem.isTwoHanded)) {
				speed = 0;
				prepAnimationFrame = -1;
				prepAnimationTotalFrames = 0;
				isPreparingAttack = false;
				isAttacking = true;
				stamina -= currentAttackingHandItem.staminaCostArray[global.playerAttackNumberInChain-1];
				global.owner = id;
				instance_create_depth(x,y,1,obj_attack_parent);
			}
			else {
				prepAnimationFrame = prepAnimationTotalFrames - 1;
				isReadyToFire = true;
			}
		}
		
		if isReadyToFire && LEFTRELEASED && stamina > 0 {
			speed = 0;
			prepAnimationFrame = -1;
			prepAnimationTotalFrames = 0;
			isPreparingAttack = false;
			isReadyToFire = false;
			//isAttacking = true;
			stamina -= currentAttackingHandItem.staminaCostArray[global.playerAttackNumberInChain-1];
			global.owner = id;
			instance_create_depth(x,y,1,obj_attack_parent);
			
		}
		
		// attack animation frame logic shit is in attack_parent
		if recoverAnimationFrame >= recoverAnimationTotalFrames {
			recoverAnimationFrame = -1;
			recoverAnimationTotalFrames = 0
			global.playerAttackNumberInChain = 1;
			isRecovering = false;
			currentAttackingHand = noone;
			attackAgain = false;
			attackAgainSameSide = false;
			state = CombatantStates.Idle;
		}
		break;
	}
}



